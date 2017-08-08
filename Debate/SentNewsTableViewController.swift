//
//  SentNewsTableViewController.swift
//  Debate
//
//  Created by Cindy Zhao on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AFNetworking

class SentNewsTableViewController: UITableViewController {

    var group : Group?
    var news = [News]()
    var filteredNews = [News]()
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Georgia", size: 17)!], for: .normal)
        
        //changes color of bar button and navigation controller
        barButton.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Georgia", size: 17)!], for: UIControlState.normal)
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Georgia", size: 20)!]
        
        
        let ref = Database.database().reference().child("groups").child(group!.id).child("news")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return }
            for snap in snapshot {
            let new = News(snapshot: snap)
            self.news.append(new!)

            }
            if self.news.count > 70 {
                GroupService.deletefromGroup(groupID: self.group!.id, url: self.news[0].url, completion: { 
                    self.news.remove(at: 0)

                })
            }
            
            for n in self.news {
                n.date2 = n.date.toDateTime1()
            }
            self.news.reverse()
            self.tableView.reloadData()

        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        news = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search by tags"
        tableView.tableHeaderView = searchController.searchBar

        self.navigationItem.title = group!.groupName
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredNews = news.filter { new in
            
            var allTags = ""

            for n in new.tags ?? [] {
                allTags += "\(n) "
            }
            print(allTags)
            return allTags.lowercased().contains(searchText.lowercased())

            }
        
        filteredNews.reverse()
        
        tableView.reloadData()
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredNews.count
        }
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentNewsTableViewCell", for: indexPath) as! SentNewsTableViewCell
        
        
        var new : News
        if searchController.isActive && searchController.searchBar.text != "" {
            new = filteredNews[indexPath.row]
        } else {
            new = news[indexPath.row]
        }
        
        cell.titleLabel.text = new.title
        let now1 = new.date2!.timeIntervalSinceNow
        let now = now1 - 25200
        if convertSecondToDateAgo(seconds: Int(-now)).contains("-") {
            cell.dateLabel.text = ""
        } else {
            cell.dateLabel.text = convertSecondToDateAgo(seconds: Int(-now))
        }
        //        cell.dateLabel.text = new.date2!.toString1(dateFormat: "dd-MMM-yyyy HH:mm:ss")
        
        //        let now1 = new.date2!.timeIntervalSinceNow
        //        let now = now1 - 25200
        //        print(convertSecondToDateAgo(seconds: Int(-now)))
        //        cell.urlLabel.text = new.url
        //
        //        var separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0.8))
        //        /// change size as you need.
        //        separatorLineView.backgroundColor = UIColor(red:0.16, green:0.16, blue:0.50, alpha:1.0)
        //
        //
        //        // you can also put image here
        //        cell.contentView.addSubview(separatorLineView)
    
//        cell.dateLabel.text = new.date2!.toString(dateFormat: "dd-MMM-yyyy HH:mm:ss")
        var allTags = ""
        for tag in new.tags ?? [] {
            allTags += "\(tag) "
        }
        cell.tagsLabel.text = allTags
        
        if new.imageURL != "" {
            let picURL = URL(string: (new.imageURL)!)!
            cell.image1.setImageWith(picURL)
        } else {
            let picURL = URL(string : "https://static.pexels.com/photos/242236/pexels-photo-242236.jpeg")
            cell.image1.setImageWith(picURL!)
        }
        
        print (new.date2)
        print(now1)
        print(Date())
        
        let ref = Database.database().reference().child("users").child(new.sender!).child("username")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            cell.senderLabel.text = snapshot.value as? String

        })
    
        return cell
    }


func convertSecondToDateAgo(seconds: Int) -> String {
    var result: String?
    if(seconds <= 59) {
        result = "\(seconds) s"
    } else if(seconds/60 <= 59) {
        result = "\(seconds/60) m"
    } else if (seconds/3600 <= 23) {
        result = "\(seconds/3600) h"
    } else {
        result = "\(seconds/86400) d"
    }
    return result!
}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toMembersList" {
                // 1
//                let indexPath = tableView.indexPathForSelectedRow!
                // 3
                let MembersTableViewController = segue.destination as! MembersTableViewController
                // 4
                MembersTableViewController.group = group
            }
        else if identifier == "toDetailedNews" {
                    // 1
                    let indexPath = tableView.indexPathForSelectedRow!
                    // 2
                let new: News
                if searchController.isActive && searchController.searchBar.text != "" {
                    new = filteredNews[indexPath.row]
                } else {
                    new = news[indexPath.row]
                }
                    // 3
                    let detailedNewsViewController = segue.destination as! DetailedNewsViewController
                    // 4
                    detailedNewsViewController.news = new
                }
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
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

extension SentNewsTableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

extension String
{
    func toDateTime1() -> Date
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)! as Date
        
        //Return Parsed Date
        return dateFromString
    }
    
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
