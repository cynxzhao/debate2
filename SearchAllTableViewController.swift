//
//  SearchAllTableViewController.swift
//  Debate
//
//  Created by Cindy Zhao on 7/14/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class SearchAllTableViewController: UITableViewController {

    var newMember : User?
    
    
    var motions = [User]()
    var filteredMotions = [User]()
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var noUsersView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search for users by username"
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredMotions = motions.filter { motion in
            return motion.username.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noUsersView.isHidden = false
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return }
            //print(snapshot[0])
            for snap in snapshot {
                let user = User(snapshot: snap)
                self.motions.append(user!)
            }
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.motions = []
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredMotions.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchAllTableViewCell", for: indexPath) as! SearchAllTableViewCell
        
        var user : User
//        if searchController.isActive && searchController.searchBar.text != "" {
            user = filteredMotions[indexPath.row]
//        } else {
//            user = users[indexPath.row]
//        }
        
        cell.usernameLabel.text = user.username
        cell.nameLabel.text = user.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath){
        self.navigationController?.popViewController(animated: true)
        self.performSegue(withIdentifier: "toMembers", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toMembers" {
                
                // NotificationCenter.default.post(name: Notification.Name(rawValue: "added"), object: self)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "addedAll"), object: self)

                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let user: User
                if searchController.isActive && searchController.searchBar.text != "" {
                    user = filteredMotions[indexPath.row]
                } else {
                    user = motions[indexPath.row]
                }
                
                let membersTableViewController = segue.destination as! MembersTableViewController
                // 4
                membersTableViewController.user = user
                
            }
        }
    }
    
//        override func tableView(_ tableView: UITableView,
//                       didSelectRowAt indexPath: IndexPath){
//            self.navigationController?.popViewController(animated: true)
//            self.performSegue(withIdentifier: "toMembers", sender: nil)
//        }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchAllTableViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        noUsersView.isHidden = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        print("hi")
        //        search = true
        filterContentForSearchText(searchText: searchController.searchBar.text!)
        noUsersView.isHidden = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredMotions = []
        noUsersView.isHidden = false
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredMotions = []
            tableView.reloadData()
        }
    }
}


//extension SearchAllTableViewController : UISearchResultsUpdating {
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchText: searchController.searchBar.text!)
//    }
//}
