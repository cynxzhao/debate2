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
            
            NewsService.create(group: group!, title: news!.title, date: news!.date, url: news!.url, tags: [" "], sender: User.current, completion: { (news) in
                guard let news = news else { return }
            })
            self.performSegue(withIdentifier: "toAll", sender: nil)


        }
        else {

            let tags: String = " " + tagsTextField.text!
            tagsArr = tags.components(separatedBy: " #")
            tagsArr.remove(at: 0)
            NewsService.create(group: group!, title: news!.title, date: news!.date, url: news!.url, tags: tagsArr, sender: User.current, completion: { (news) in
                guard let news = news else { return }
            })
            
            self.performSegue(withIdentifier: "toAll", sender: nil)

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
