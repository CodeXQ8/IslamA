//
//  PostVC.swift
//  Islam
//
//  Created by Nayef Alotaibi on 9/2/18.
//  Copyright © 2018 Nayef Alotaibi. All rights reserved.
//

import UIKit
import WebKit

let defaults = UserDefaults(suiteName: "Islam.Explored")

class PostVC: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var WKView: WKWebView!
    @IBOutlet weak var postContent: UITextView!
    
    var html : String = " "
    var postTitle  : String = " "
    var postId : Int = 0
    
    var containerHeight = CGFloat()
    var contentString = String()
    var index : Int = 0
    var isSaved = Bool ()
    
    var savedPost = [Int]()
    var saved : Bool = false

    var posts : [Post]?
    
    var post: Post? {
        didSet {
            html = (post?.content)!
            postTitle = (post?.title)!
            postId = (post?.id)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        webKitSetUp()
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateSaveImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getData()
    }
    
    func updateSaveImage(){
     if let index = savedPost.index(of: postId) {
     savedBtn.image = UIImage(named: "bookmark-fill")
    } else {
    savedBtn.image = UIImage(named: "bookmark")
    }
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
      //  storeData(savedPost: <#[Int]#>)
    }

    func webKitSetUp(){
        WKView.navigationDelegate = self
        WKView.isUserInteractionEnabled = true
        WKView.isMultipleTouchEnabled = true;
        WKView.scrollView.showsHorizontalScrollIndicator = false
        WKView.scrollView.showsVerticalScrollIndicator = false
        WKView.backgroundColor = UIColor .clear;
        WKView.clipsToBounds = true
      
        WKView.loadHTML(html: html, title: postTitle)
    }
    
    func storeData(savedPost : [Int]){
        defaults?.set(savedPost, forKey: "savedPost")
    }
    
    func getData(){
        let data = defaults?.value(forKey: "savedPost")
        if data != nil {
            self.savedPost = data as! [Int]
        } else {
            
        }
    }
//    [1403, 1173, 1632, 1475, 2637, 1493]
    @IBOutlet weak var savedBtn: UIBarButtonItem!
    @IBAction func SaveBtnWasPressed(_ sender: Any) {
        
        
        if let index = savedPost.index(of: postId) {
            savedPost.remove(at: index)
            print(savedPost)
            storeData(savedPost: savedPost)
//            print(UserDefaults.standard.array(forKey: "savedPost"))
            savedBtn.image = UIImage(named: "bookmark")
        } else {
            savedPost.append(postId)
            print(savedPost)
            storeData(savedPost: savedPost)
//            print(UserDefaults.standard.array(forKey: "savedPost"))
            savedBtn.image = UIImage(named: "bookmark-fill")
        }
        
    }
    
    
    
}
extension WKWebView {
    
    func loadHTML(html: String, title: String) {
        let htmlString = """
        <link rel="stylesheet" type="text/css" href="style.css">
        <h1> \(String(htmlEncodedString:title)) </h1>
        <meta name="viewport" content="initial-scale=1.0" />
        <span>\(html)</span>
        """
        self.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    }
}
