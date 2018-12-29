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
var savedForLaterArray = Array<Post>()

class PostVC: UIViewController, WKNavigationDelegate {
    
    
    @IBOutlet weak var WKView: WKWebView!
    @IBOutlet weak var postContent: UITextView!
    

    
    var html : String = " "
    var postTitle  : String = " "
    var postId : Int = 0
    var link : String = " "
    
    var containerHeight = CGFloat()
    var contentString = String()
    var index : Int = 0
    var isSaved = Bool ()
    
    var isDark : Bool = false
    
    var savedPost = [Int]()
    var saved : Bool = false

    var posts : [Post]?
    
    var post: Post? {
        didSet {
            html = (post?.content)!
            postTitle = (post?.title)!
            postId = (post?.id)!
            link = (post?.link)!
        }
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  view.mixedBackgroundColor = MixedColor(normal: 0xfafafa, night: 0x222222)


        
        getData()
        updateSaveImage()
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
    
    
    @IBOutlet weak var nightModeBtn: UIBarButtonItem!
    
//    @IBAction func nightModeBtnWasPressed(_ sender: Any) {
//
//        navigationController?.navigationBar.mixedBarTintColor = MixedColor(normal: 0x2C8587, night: 0x222222)
//        navigationController?.navigationBar.mixedTintColor = MixedColor(normal: 0xffffff, night: 0xfafafa)
//        navigationController?.navigationBar.mixedBarStyle = MixedBarStyle(normal: .default, night: .black)
//
//
//       changeTheme()
//
//    }
    
    
//     func changeToNormal() {
//        NightNight.theme = .normal
//    }
//    
//     func changeToNight() {
//        NightNight.theme = .night
//    }
//    
//     func changeTheme() {
//        if NightNight.theme == .night {
//            NightNight.theme = .normal
//        } else {
//            NightNight.theme = .night
//        }
//    }
//    
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return MixedStatusBarStyle(normal: .default, night: .lightContent).unfold()
//        
//    }
    
    
    
    func updateSaveImage(){
     if let index = savedPost.index(of: postId) {
     savedBtn.image = UIImage(named: "bookmark-fill")
    } else {
    savedBtn.image = UIImage(named: "bookmark")
    }
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        getData()
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
    
    
    func containPostId(postId: Int) -> Bool {
        let exists = savedForLaterArray.contains(where: { (post) -> Bool in
            if post.id == postId {
                return true
            } else {
                return false
            }
        })
        return exists
    }

    func getData(){
        let data = defaults?.value(forKey: "savedPost") as? [Int]
      
        if data != nil{
            self.savedPost = data as! [Int]
            if posts != nil  {
            for postId in data! {
                            for post in posts! {
                                if postId == post.id{
                                    let exists = containPostId(postId: postId)
                                    if exists != true {
                                            savedForLaterArray.insert(post, at: 0)
                                    }
                                }
                            }
                        }
            }
        }
        else {
            
        }
    }

    @IBOutlet weak var savedBtn: UIBarButtonItem!
    @IBAction func SaveBtnWasPressed(_ sender: Any) {
        
        
        if let index = savedPost.index(of: postId) {
            savedPost.remove(at: index)
            savedForLaterArray.remove(at: index)
            print(savedPost)
            storeData(savedPost: savedPost)
            savedBtn.image = UIImage(named: "bookmark")
        } else {
            savedPost.insert(postId, at: 0)
            print(savedPost)
            storeData(savedPost: savedPost)
            savedBtn.image = UIImage(named: "bookmark-fill")
        }
        
    }
    
    /// Get the Link from wordpress ///
    @IBAction func shareBtnWasPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems:[ postTitle,"\n\(link)"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC,animated: true, completion: nil)
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
