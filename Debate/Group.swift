//
//  Group.swift
//  Debate
//
//  Created by Cindy Zhao on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase.FIRDataSnapshot

class Group {
    let groupName: String
    var users: [String]
    var news = [News]()
    var id: String
    var lastDate : String?
    
    init(groupName: String, users: [String], id: String) {
        self.groupName = groupName
        self.users = users
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
        let groupName = dict["groupName"] as? String,
        let users = dict["users"] as? [String],
        let id = dict["id"] as? String,
        let lastDate = dict["date"] as? String
            else {return nil}
        
        self.groupName = groupName
        self.users = users
        self.id = id
        self.lastDate = lastDate
    }

}
