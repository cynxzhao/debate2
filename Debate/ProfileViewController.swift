//
//  PersonalInfoViewController.swift
//  Debate
//
//  Created by Cindy Zhao on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aboutMeLabel: UILabel!
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var barButton2: UIBarButtonItem!
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        
        if Auth.auth().currentUser != nil {
        do {
     try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
            } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.black
        //changes color of bar button and navigation controller
        barButton.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Georgia", size: 17)!], for: UIControlState.normal)
        
        barButton2.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Georgia", size: 17)!], for: UIControlState.normal)

        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Georgia", size: 20)!]
        
        UserService.show(forUID: User.current.uid) { (user) in

            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
        self.nameLabel.text = User.current.name
        self.usernameLabel.text = User.current.username
        self.aboutMeLabel.text = User.current.aboutMe
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
