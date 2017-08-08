//
//  SendNewsViewController.swift
//  Debate
//
//  Created by Cindy Zhao on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class SendNewsViewController: UIViewController {
    
    var groups = [Group]()
    var group : Group?
    var news : News?
    
    @IBAction func screenTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    var text : String?
    var tagsArr = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tagsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        text = tagsTextField.text
        self.navigationController?.isNavigationBarHidden = false
        var groupIDs = [String]()
        self.groups = []
        let ref = Database.database().reference().child("users").child(User.current.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let user = User(snapshot: snapshot) {
                groupIDs = user.groups!
                let ref1 = Database.database().reference().child("groups")
                ref1.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                        else { return }
                    //print(snapshot[0])
                    for snap in snapshot {
                        for id in groupIDs {
                            if id == snap.key {
                                let group1 = Group(snapshot: snap)
                                self.groups.append(group1!)
                            }
                        }
                    }
                    self.tableView.reloadData()
                    groupIDs = []
                })
            }
        })
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.groups = []
    }


    @IBAction func newsSent(_ sender: UIButton) {
        if group == nil {
            
            let alert = UIAlertController(title: "Error", message: "Please choose a group", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if tagsTextField.text == "" {

/*            let alert = UIAlertController(title: "Error", message: "Please add tags for search purposes", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil) */
            
            NewsService.create(group: group!, title: news!.title, date: news!.date, url: news!.url, tags: [" "], sender: User.current, imageURL: news!.imageURL!, completion: { (news) in
                guard let news = news else { return }
            })
            self.performSegue(withIdentifier: "toAll", sender: nil)


        }

        else {
            var tagsArr1 = tagsTextField.text!.components(separatedBy: "#")
            tagsArr1.remove(at: 0)
            for tag in tagsArr1 {
                var newTag = tag.removingWhitespaces()
                tagsArr.append(newTag)
            }
            if tagsArr.count > 5 {
                let alert = UIAlertController(title: "Error", message: "Maximum 5 tags", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if tagsArr.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Please add tags in the correct format", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else { NewsService.create(group: group!, title: news!.title, date: news!.date, url: news!.url, tags: tagsArr, sender: User.current, imageURL: news!.imageURL!, completion: { (news) in
                guard let news = news else { return }
            })
            
            self.performSegue(withIdentifier: "toAll", sender: nil)

        }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SendNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if searchController.isActive && searchController.searchBar.text != "" {
//            return filteredUsers.count
//        }
        return groups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sendNewsTableViewCell", for: indexPath) as! SendNewsTableViewCell
        
//        if searchController.isActive && searchController.searchBar.text != "" {
//            user = filteredUsers[indexPath.row]
//        } else {
            group = groups [indexPath.row]
//        }
        
        cell.groupNameLabel.text = group!.groupName
        
        group = nil
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        group = groups [indexPath.row]
        
    }
    
}

extension SendNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
