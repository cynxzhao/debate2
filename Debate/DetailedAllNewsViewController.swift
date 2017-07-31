//
//  DetailedAllNewsViewController.swift
//  Debate
//
//  Created by Cindy Zhao on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailedAllNewsViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    var news : News?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //webView.stopLoading()
        //webView.removeFromSuperview()
        //webView = nil
        
//        URLCache.shared.removeAllCachedResponses()
//        URLCache.shared.diskCapacity = 0
//        URLCache.shared.memoryCapacity = 0
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            for cookie in cookies {
//                HTTPCookieStorage.shared.deleteCookie(cookie)
//            }
//        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()

    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activity.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self

        let url = self.news!.url
        let requestURL = NSURL(string:url)
//        let request = NSURLRequest(url:requestURL! as URL)
        let r = NSURLRequest(url: requestURL! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5.0)
        webView.loadRequest(r as URLRequest)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        NewsService.save(userID: User.current.uid, title: news!.title, date: news!.date, url: news!.url) { (news) in
            guard let news = news else { return }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toSend" {
                let SendNewsViewController = segue.destination as! SendNewsViewController
                // 4
                SendNewsViewController.news = news
            }
        }
    }
    
    @IBAction func unwindToDetailedAllTableViewController(_ segue: UIStoryboardSegue) {
        
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
