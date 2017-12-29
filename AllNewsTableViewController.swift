//
//  AllNewsTableViewController.swift
//  Debate
//
//  Created by Cindy Zhao on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import AFNetworking

class AllNewsTableViewController: UITableViewController {
    
    var others = false
    var news = [News]()

    @IBOutlet weak var ABC1: UIButton!
    @IBOutlet weak var AlJazeera1: UIButton!
    @IBOutlet weak var AP1: UIButton!
    @IBOutlet weak var BBC1: UIButton!
    @IBOutlet weak var BusinessInsider1: UIButton!
    @IBOutlet weak var CNBC1: UIButton!
    @IBOutlet weak var CNN1: UIButton!
    @IBOutlet weak var Economist1: UIButton!
    @IBOutlet weak var HuffingtonPost1: UIButton!
    @IBOutlet weak var Guardian1: UIButton!
    @IBOutlet weak var WashingtonPost1: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Georgia", size: 20)!]
        

    }
    
    // ABC BUTTON
    @IBAction func ABC(_ sender: UIButton) {
        if ABC1.backgroundColor == UIColor.white {
            ABC1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=abc-news-au&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let ABCnewsData = JSON(json: response.result.value!)
                let ABCData = ABCnewsData["articles"].arrayValue
                
                for b in ABCData {
                    let bb = News(otherjson: b)
                    self.news.append(bb)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main, execute: {
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true
                self.others = true
            })

        }
        else if ABC1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            ABC1.backgroundColor = UIColor.white
            
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("abc.net.au")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white {
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    // AL JAZEERA BUTTON
    @IBAction func AlJazeera(_ sender: UIButton) {
        if AlJazeera1.backgroundColor == UIColor.white{
            AlJazeera1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=al-jazeera-english&sortBy=latest&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let AlnewsData = JSON(json: response.result.value!)
                let AlData = AlnewsData["articles"].arrayValue
                
                for b in AlData {
                    let bb = News(otherjson: b)
                    self.news.append(bb)
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true
            })
        }
            
        else if AlJazeera1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            AlJazeera1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("aljazeera.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
            
        }
    }
    
    // ASSOCIATED PRESS BUTTON
    @IBAction func AssociatedPress(_ sender: UIButton) {
        if AP1.backgroundColor == UIColor.white{
            AP1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=associated-press&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let AnewsData = JSON(json: response.result.value!)
                let AData = AnewsData["articles"].arrayValue
                
                for a in AData {
                    let aa = News(otherjson: a)
                    self.news.append(aa)
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true
            })
        }
        else if AP1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            AP1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("apnews.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    // BBC BUTTON
    @IBAction func BBC(_ sender: UIButton) {
        if BBC1.backgroundColor == UIColor.white{
            BBC1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=bbc-news&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let BBCnewsData = JSON(json: response.result.value!)
                let BBCData = BBCnewsData["articles"].arrayValue
                
                for bbc in BBCData {
                    let bbcc = News(otherjson: bbc)
                    self.news.append(bbcc)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main, execute: {
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true
            })
        }
            
        else if BBC1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            BBC1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("bbc.co.uk")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    // BUSINESS INSIDER BUTTON
    @IBAction func BusinessInsider(_ sender: UIButton) {
        if BusinessInsider1.backgroundColor == UIColor.white{
            BusinessInsider1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=business-insider&sortBy=latest&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let BnewsData = JSON(json: response.result.value!)
                let BData = BnewsData["articles"].arrayValue
                
                for b in BData {
                    let bb = News(otherjson: b)
                    self.news.append(bb)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main, execute: {
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true
            })
            
        }
        else if BusinessInsider1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            BusinessInsider1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("businessinsider.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    // CNBC BUTTON
    @IBAction func CNBC(_ sender: UIButton) {
        if CNBC1.backgroundColor == UIColor.white{
            CNBC1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=cnbc&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let CNnewsData = JSON(json: response.result.value!)
                let CNData = CNnewsData["articles"].arrayValue
                
                for b in CNData {
                    let bb = News(otherjson: b)
                    self.news.append(bb)
                }
                dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main, execute: {
                
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true
            })
        }
            
        else if CNBC1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            CNBC1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("cnbc.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white {
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    // CNN BUTTON
    @IBAction func CNN(_ sender: UIButton) {
        if CNN1.backgroundColor == UIColor.white{
            CNN1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=cnn&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let CnewsData = JSON(json: response.result.value!)
                let CData = CnewsData["articles"].arrayValue
                
                for b in CData {
                    let bb = News(otherjson: b)
                    self.news.append(bb)
                }
                dispatchGroup.leave()
            }

            dispatchGroup.notify(queue: .main, execute: {
                
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true

            })
            
        }
        else if CNN1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            CNN1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("cnn.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    // ECONOMIST BUTTON
    
    @IBAction func Economist(_ sender: UIButton) {
        if Economist1.backgroundColor == UIColor.white{
            Economist1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=the-economist&sortBy=latest&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let EnewsData = JSON(json: response.result.value!)
                let EData = EnewsData["articles"].arrayValue
                
                for e in EData {
                    let ee = News(otherjson: e)
                    self.news.append(ee)
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true

            })
        }
        else if Economist1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            Economist1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("economist.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
    }
    
    // HUFFINGTON POST BUTTON
    @IBAction func HuffingtonPost(_ sender: UIButton) {
        if HuffingtonPost1.backgroundColor == UIColor.white{
            HuffingtonPost1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=the-huffington-post&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let HnewsData = JSON(json: response.result.value!)
                let HData = HnewsData["articles"].arrayValue
                
                for h in HData {
                    let hh = News(otherjson: h)
                    self.news.append(hh)
                }
                dispatchGroup.leave()
            }

            dispatchGroup.notify(queue: .main, execute: {
                
                var x = 0
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true

            })

        }
        else if HuffingtonPost1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            HuffingtonPost1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("huffingtonpost.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
            //jjjj
        }
    }
    
    // GUARDIAN BUTTON
    @IBAction func Guardian(_ sender: UIButton) {
        if Guardian1.backgroundColor == UIColor.white{
            Guardian1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://content.guardianapis.com/search?order-by=newest&page-size=50&from-date=2017-07-18&api-key=426baee8-e5b2-45f3-b569-55c660e95afa&show-fields=thumbnail")
                .responseJSON { response in
                    let GnewsData = JSON(json: response.result.value!)
                    var GData = GnewsData["response"]["results"].arrayValue
                    
                    for g in GData {
                        let gg = News(guardianjson: g)
                        self.news.append(gg)
                    }
                    dispatchGroup.leave()
            }
            dispatchGroup.notify(queue: .main, execute: {
                
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true

            })
        }
        else if Guardian1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            Guardian1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("theguardian.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }

    }
    
    // WASHINGTON POST BUTTON
    @IBAction func WashingtonPost(_ sender: UIButton) {
        if WashingtonPost1.backgroundColor == UIColor.white{
            WashingtonPost1.backgroundColor = UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0)
            if others == false {
                news = []
            }
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            Alamofire.request("https://newsapi.org/v1/articles?source=the-washington-post&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
                let WnewsData = JSON(json: response.result.value!)
                let WData = WnewsData["articles"].arrayValue
                
                for w in WData {
                    let ww = News(otherjson: w)
                    self.news.append(ww)
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                
                var x = 0
                
                for n in self.news {
                    if n.date.characters.count != 20 {
                        self.news.remove(at: x)
                    } else {
                        n.date2 = n.date.toDateTime()
                        x += 1
                    }
                }
                self.news = self.news.sorted(by: >)
                self.tableView.reloadData()
                self.others = true

            })
        }
        else if WashingtonPost1.backgroundColor == UIColor(red:0.69, green:0.90, blue:0.95, alpha:1.0) {
            WashingtonPost1.backgroundColor = UIColor.white
            news = news.filter({ (new) -> Bool in
                return !new.url.contains("washingtonpost.com")
            })
            
            if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
                reload()
                others = false
            }
            
            self.tableView.reloadData()
        }
    }
    //    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ABC1.titleLabel?.adjustsFontSizeToFitWidth = true
        AlJazeera1.titleLabel?.adjustsFontSizeToFitWidth = true
        AP1.titleLabel?.adjustsFontSizeToFitWidth = true
        BBC1.titleLabel?.adjustsFontSizeToFitWidth = true
        BusinessInsider1.titleLabel?.adjustsFontSizeToFitWidth = true
        CNBC1.titleLabel?.adjustsFontSizeToFitWidth = true
        CNN1.titleLabel?.adjustsFontSizeToFitWidth = true
        Economist1.titleLabel?.adjustsFontSizeToFitWidth = true
        HuffingtonPost1.titleLabel?.adjustsFontSizeToFitWidth = true
        Guardian1.titleLabel?.adjustsFontSizeToFitWidth = true
        WashingtonPost1.titleLabel?.adjustsFontSizeToFitWidth = true
        
        ABC1.backgroundColor = UIColor.white
        AlJazeera1.backgroundColor = UIColor.white
        AP1.backgroundColor = UIColor.white
        BBC1.backgroundColor = UIColor.white
        BusinessInsider1.backgroundColor = UIColor.white
        CNBC1.backgroundColor = UIColor.white
        CNN1.backgroundColor = UIColor.white
        Economist1.backgroundColor = UIColor.white
        HuffingtonPost1.backgroundColor = UIColor.white
        Guardian1.backgroundColor = UIColor.white
        WashingtonPost1.backgroundColor = UIColor.white
        
        ABC1.layer.cornerRadius = 8
        AlJazeera1.layer.cornerRadius = 8
        AP1.layer.cornerRadius = 8
        BBC1.layer.cornerRadius = 8
        BusinessInsider1.layer.cornerRadius = 8
        CNBC1.layer.cornerRadius = 8
        CNN1.layer.cornerRadius = 8
        Economist1.layer.cornerRadius = 8
        HuffingtonPost1.layer.cornerRadius = 8
        Guardian1.layer.cornerRadius = 8
        WashingtonPost1.layer.cornerRadius = 8
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ABC1.backgroundColor == UIColor.white && AlJazeera1.backgroundColor == UIColor.white && AP1.backgroundColor == UIColor.white && BBC1.backgroundColor == UIColor.white && BusinessInsider1.backgroundColor == UIColor.white && CNBC1.backgroundColor == UIColor.white && CNN1.backgroundColor == UIColor.white && Economist1.backgroundColor == UIColor.white && HuffingtonPost1.backgroundColor == UIColor.white && Guardian1.backgroundColor == UIColor.white && WashingtonPost1.backgroundColor == UIColor.white{
            reload()
            others = false
        }
        
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func reload() {
        news = []
        
        var GData, BData, AData, EData, WData, LData, HData, BBCData: [JSON]?
        
        let dispatchGroup = DispatchGroup()
        // ABC
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=abc-news-au&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let ABCnewsData = JSON(json: response.result.value!)
            let ABCData = ABCnewsData["articles"].arrayValue
            
            for b in ABCData {
                let bb = News(otherjson: b)
                self.news.append(bb)
            }
            dispatchGroup.leave()
        }
        // Al Jazeera
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=al-jazeera-english&sortBy=latest&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let AlnewsData = JSON(json: response.result.value!)
            let AlData = AlnewsData["articles"].arrayValue
            
            for b in AlData {
                let bb = News(otherjson: b)
                self.news.append(bb)
            }
            dispatchGroup.leave()
        }
        // CNBC
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=cnbc&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let CNnewsData = JSON(json: response.result.value!)
            let CNData = CNnewsData["articles"].arrayValue
            
            for b in CNData {
                let bb = News(otherjson: b)
                self.news.append(bb)
            }
            dispatchGroup.leave()
        }
        // CNN
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=cnn&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let CnewsData = JSON(json: response.result.value!)
            let CData = CnewsData["articles"].arrayValue
            
            for b in CData {
                let bb = News(otherjson: b)
                self.news.append(bb)
            }
            dispatchGroup.leave()
        }
        // Business Insider
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=business-insider&sortBy=latest&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let BnewsData = JSON(json: response.result.value!)
            BData = BnewsData["articles"].arrayValue
            
            for b in BData! {
                let bb = News(otherjson: b)
                self.news.append(bb)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        // Guardian
        Alamofire.request("https://content.guardianapis.com/search?order-by=newest&page-size=50&from-date=2017-07-18&api-key=426baee8-e5b2-45f3-b569-55c660e95afa&show-fields=thumbnail")
            .responseJSON { response in
                let GnewsData = JSON(json: response.result.value!)
                GData = GnewsData["response"]["results"].arrayValue
                
                for g in GData! {
                    let gg = News(guardianjson: g)
                    self.news.append(gg)
                }
                dispatchGroup.leave()
        }
        // Associated Press
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=associated-press&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let AnewsData = JSON(json: response.result.value!)
            AData = AnewsData["articles"].arrayValue
            
            for a in AData! {
                let aa = News(otherjson: a)
                self.news.append(aa)
            }
            dispatchGroup.leave()
        }
        
        // Economist
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=the-economist&sortBy=latest&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let EnewsData = JSON(json: response.result.value!)
            EData = EnewsData["articles"].arrayValue
            
            for e in EData! {
                let ee = News(otherjson: e)
                self.news.append(ee)
            }
            dispatchGroup.leave()
        }
        
        // Washington Post
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=the-washington-post&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let WnewsData = JSON(json: response.result.value!)
            WData = WnewsData["articles"].arrayValue
            
            for w in WData! {
                let ww = News(otherjson: w)
                self.news.append(ww)
            }
            dispatchGroup.leave()
        }
        
        // Huffington Post
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=the-huffington-post&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let HnewsData = JSON(json: response.result.value!)
            HData = HnewsData["articles"].arrayValue
            
            for h in HData! {
                let hh = News(otherjson: h)
                self.news.append(hh)
            }
            dispatchGroup.leave()
        }
        
        // BBC
        dispatchGroup.enter()
        Alamofire.request("https://newsapi.org/v1/articles?source=bbc-news&apiKey=069c5469ce9a4cce87b2efb29a06bf90").responseJSON { response in
            let BBCnewsData = JSON(json: response.result.value!)
            BBCData = BBCnewsData["articles"].arrayValue
            
            for bbc in BBCData! {
                let bbcc = News(otherjson: bbc)
                self.news.append(bbcc)
            }
            dispatchGroup.leave()
        }
        
        
//        if self.myRefreshControl.isRefreshing {
//            self.myRefreshControl.endRefreshing()
//        }
        
        dispatchGroup.notify(queue: .main, execute: {
            var x = 0
            
            for n in self.news {
                if n.date.characters.count != 20 {
                    self.news.remove(at: x)
                } else {
                    n.date2 = n.date.toDateTime()
                    x += 1
                }
            }
            self.news = self.news.sorted(by: >)
            self.tableView.reloadData()
        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allNewsTableViewCell", for: indexPath) as! AllNewsTableViewCell
        
        // 1
        let row = indexPath.row
        
        // 2
        let new = news[row]
        
        DispatchQueue.main.async {
            
            if new.imageURL != "" {
                let picURL = URL(string: (new.imageURL)!)!
                cell.image1.setImageWith(picURL)
            } else {
                let picURL = URL(string : "https://static.pexels.com/photos/242236/pexels-photo-242236.jpeg")
                cell.image1.setImageWith(picURL!)
            }
        }
    
        cell.titleLabel.text = new.title
//        var now1 = new.date2!.timeIntervalSinceNow
//        let now = now1
//
//        if convertSecondToDateAgo(seconds: Int(-now)).contains("-") {
//            cell.dateLabel.text = ""
//        } else {
//            cell.dateLabel.text = convertSecondToDateAgo(seconds: Int(-now))
//        }
//        cell.dateLabel.text = new.date2!.toString1(dateFormat: "dd-MMM-yyyy HH:mm:ss")
//        
//        let now = new.date2!.timeIntervalSinceNow
//        print(convertSecondToDateAgo(seconds: Int(-now)))
//        cell.urlLabel.text = new.url
        
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //news = []
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toDetailedAllNews" {
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let new = news[indexPath.row]
                // 3
                let detailedAllNewsViewController = segue.destination as! DetailedAllNewsViewController
                // 4
                detailedAllNewsViewController.news = new
            }
        }
    }
    
    @IBAction func unwindToAllNewsTableViewController(_ segue: UIStoryboardSegue) {
        
    }
    
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
    
}

extension String
{
    func toDateTime() -> Date
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
    func toString1( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
