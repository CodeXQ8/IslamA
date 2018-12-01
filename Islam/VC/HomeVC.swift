//
//  HomeVC.swift
//  Islam
//
//  Created by Nayef Alotaibi on 10/4/18.
//  Copyright © 2018 Islam. All rights reserved.
//

import UIKit
import SideMenu
import EmptyDataSet_Swift

var postType = 0
var isReload = true
var recentlyViewdPost = Array<Post>()
var recentlyViewdInt = [Int]()

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var childVC: UIView!
    

    var postsArticles = Array<Post>()
    var postsFqa = Array<Post>()
    var posts = Array<Post>()
   // var recentlyViewdInt = [Int]()
  

    
    let articles = 35
    let fqa = 36
    let foundation = 158
    let recentlyViewd = 1
    let savedForLater = 2

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
     
        getDataSavedPost()
        getDataRecentViewedPost()
        fetchAllPosts()
        SideMenuManager.default.menuFadeStatusBar = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        storeData(savedForLaterInt: recentlyViewdInt)
        getDataRecentViewedPost()
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

    func containRecentViewedPost(postId: Int) -> Bool {
        let exists = recentlyViewdPost.contains(where: { (post) -> Bool in
            if post.id == postId {
                return true
            } else {
                return false
            }
        })
        return exists
    }

    func storeData(savedForLaterInt : [Int]){
        defaults?.set(savedForLaterInt, forKey: "savedForLaterInt")
    }


    func getDataRecentViewedPost(){
        let data = defaults?.value(forKey: "savedForLaterInt") as? [Int]
        print("recent viewed post \(data)")
        let posts = postsArticles + postsFqa
        if data != nil{
            for postId in data! {
                for post in posts {
                    if postId == post.id{
                        let exists = containRecentViewedPost(postId: postId)
                        if exists != true {
                            recentlyViewdPost.append(post)
                        }
                    }
                }
            }
        } else {

        }
    }

    
    
    func getDataSavedPost(){
        let data = defaults?.value(forKey: "savedPost") as? [Int]
        let posts = postsArticles + postsFqa
        if data != nil && posts != nil {
            for postId in data! {
                for post in posts {
                    if postId == post.id{
                        let exists = containPostId(postId: postId)
                        if exists != true {
                            savedForLaterArray.append(post)
                        }
                    }
                }
            }
        } else {
            
        }
    }

    
//    func getData(){
//    //    allPosts = postsArticles + postsFqa
////
////        let data = defaults?.value(forKey: "savedPost") as? [Int]
////        if data != nil {
////            for postId in data! {
////            for post in allPosts {
////                if postId == post.id{
////                    let exists = containPostId(postId: postId)
////                    if exists != true {
////                            savedForLaterArray.append(post)
////                    }
////                }
////            }
////        }
////    }
//    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDataSavedPost()
       getDataRecentViewedPost()
        tableView.reloadData()
     //   print("This is the saved for later array : \(savedForLaterArray)")
        navigationSetUp()
        if isReload == false  { /// Try to check which type
            if postType == 2 &&  savedForLaterArray.count != 0 {
                tableView.reloadData()
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
                isReload = true

            }
            if postType == 1 && recentlyViewdPost.count != 0 {
                tableView.reloadData()
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
                isReload = true
            }
            }
        
        
    }

    
    

    func navigationSetUp(){

        switch postType
        {
        case fqa :
           navigationItem.title = "FQA's"
        case recentlyViewd :
            navigationItem.title = "Recently Viewd"
        case savedForLater :
            navigationItem.title = "Saved for Later"
        default:
            navigationItem.title = "Articles"
        }
    }

    
    func fetchAllPosts(){
        fetchFoundation()
        fetchArticles()
        fetchFQA()
    }


    func fetchFoundation() {
        let siteURL = "https://islamexplored.org/wp-json/wp/v2"

        let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: foundation)
        postRequest.fetchLastPosts(completionHandler: { posts, error in
            if let newposts = posts {
                DispatchQueue.main.async {
                    self.postsArticles = newposts
                }
            }
        })

    }
    
    func fetchArticles() {
        let siteURL = "https://islamexplored.org/wp-json/wp/v2"
        
        let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: articles)
        postRequest.fetchLastPosts(completionHandler: { posts, error in
            if let newposts = posts {
                for post in newposts {
                DispatchQueue.main.async {
                    self.postsArticles.append(post)
                    self.tableView.reloadData()
                }
                }
            }
        })
        
    }
    
    func fetchFQA() {
        let siteURL = "https://islamexplored.org/wp-json/wp/v2"
        
        let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: fqa)
        postRequest.fetchLastPosts(completionHandler: { posts, error in
            if let newpostsF = posts {
                DispatchQueue.main.async {
                    self.postsFqa = newpostsF
                    self.tableView.reloadData()
                }
            }
        })
        
    }
    
    @IBAction func ContactUsBtnWasPrssed(_ sender: Any) {
        guard let url = URL(string: "https://islamexplored.org/contact-us/") else { return }
        UIApplication.shared.open(url)
    }
    
        var showDescription = false
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource , EmptyDataSetSource, EmptyDataSetDelegate{
    
//    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
//        let str = "You have no recently viewed posts"
//        return NSAttributedString(string: str)
//    }

    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
           var str = ""
        if showDescription == true  {
         str = "You have no posts"
        } else {
            showDescription = true 
            
        }
        return NSAttributedString(string: str)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch postType
        {
        case fqa :
        return postsFqa.count
            
        case recentlyViewd :
            return recentlyViewdPost.count
            
        case savedForLater :
            return savedForLaterArray.count
            
        default:
        return postsArticles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellPost", for: indexPath) as? CellPost else { return CellPost() }

        switch postType
        {
        case fqa :
             let post = postsFqa[indexPath.row]
             let title = String(htmlEncodedString:post.title)
             let contentLbl = String(htmlEncodedString:post.excerpt)
             cell.updateCell(title: title,contentLbl: contentLbl)
        case recentlyViewd :
            let post = recentlyViewdPost[indexPath.row]
            let title = String(htmlEncodedString:post.title)
            let contentLbl = String(htmlEncodedString:post.excerpt)
            cell.updateCell(title: title,contentLbl: contentLbl)
        case savedForLater :
            let post = savedForLaterArray[indexPath.row]
            let title = String(htmlEncodedString:post.title)
            let contentLbl = String(htmlEncodedString:post.excerpt)
            cell.updateCell(title: title,contentLbl: contentLbl)
            
        default:
             let post = postsArticles[indexPath.row]
             let title = String(htmlEncodedString:post.title)
             let contentLbl = String(htmlEncodedString:post.excerpt)
             cell.updateCell(title: title,contentLbl: contentLbl)
        }
            return cell
        
    }
    
    
    func contain(post: Post) -> Bool{

        for recentPost in recentlyViewdPost {
            if recentPost.id == post.id{
                return true
            }
        }
        return false

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let indexPath = tableView.indexPathForSelectedRow {
                
                switch postType
                {
                case fqa :
                    let selectedPost = postsFqa[indexPath.row]
              
//                    if let index = recentlyViewdInt.index(of: selectedPost.id) {
////                        recentlyViewdInt.remove(at: index)
////                        savedForLaterArray.remove(at: index)
////                        storeData(savedForLaterInt: recentlyViewdInt)
//                    } else {
//                        recentlyViewdInt.insert(selectedPost.id, at: 0)
//                        storeData(savedForLaterInt: recentlyViewdInt)
//                    }
                    
                    let postContain = contain(post: selectedPost)
                    if postContain == false {
                        recentlyViewdPost.insert(selectedPost, at: 0)
                        recentlyViewdInt.insert(selectedPost.id, at: 0)
                        storeData(savedForLaterInt: recentlyViewdInt)
                    }
                    
                    
                    let postVC = segue.destination as? PostVC
                    postVC?.post = selectedPost
                    postVC?.index = indexPath.row
                case recentlyViewd :
                    if recentlyViewdPost.count == 0 {

                    } else {
                    let selectedPost = recentlyViewdPost[indexPath.row]
                    let postVC = segue.destination as? PostVC
                    postVC?.post = selectedPost
                    postVC?.index = indexPath.row
                    }
                case savedForLater :
                    if savedForLaterArray.count == 0 {
                        
                    } else {
                        let selectedPost = savedForLaterArray[indexPath.row]
                        let postVC = segue.destination as? PostVC
                        postVC?.post = selectedPost
                        postVC?.index = indexPath.row
                    }
                    
                default:
                      let selectedPost = postsArticles[indexPath.row]
//                    if let index = recentlyViewdInt.index(of: selectedPost.id) {
//
//                    } else {
//                        recentlyViewdInt.insert(selectedPost.id, at: 0)
//                        storeData(savedForLaterInt: recentlyViewdInt)
//                    }
                    let postContain = contain(post: selectedPost)
                      if postContain == false {
                        recentlyViewdPost.insert(selectedPost, at: 0)
                        recentlyViewdInt.insert(selectedPost.id, at: 0)
                        storeData(savedForLaterInt: recentlyViewdInt)
                    }
                    let postVC = segue.destination as? PostVC
                    postVC?.post = selectedPost
                    postVC?.index = indexPath.row
                }
        }
        let SearchVC = segue.destination as? SearchVC
        SearchVC?.posts =  postsArticles + postsFqa
       // SearchVC?.recentlyViewdInt = recentlyViewdInt
        
        let PostVC = segue.destination as? PostVC
        PostVC?.posts =  postsArticles + postsFqa
        
        
        
    }
}

public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhoneX"
            case "iPhone11,2":                              return " let frame "
            case "iPhone11,4", "iPhone11,6":                return "iPhoneXsMax"
            case "iPhone11,8":                              return "iPhoneXr"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

//
//if savedForLaterArray.count != 0{
//    for postInSavedPosts in savedForLaterArray {
//        print(postId)
//        print(postInSavedPosts.id)
//
//        if postId == postInSavedPosts.id{
//            savedForLaterArray.append(post)
//            print("save for later inside getdata function \(savedForLaterArray)")
//        }
//        else {
//            print("The post is aleardy saved")
//        }
//    }
//
//} else {
//    savedForLaterArray.append(post)
//}
