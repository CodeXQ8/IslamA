//
//  SearchVC.swift
//  Islam
//
//  Created by Nayef Alotaibi on 9/15/18.
//  Copyright © 2018 Nayef Alotaibi. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating{

    
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts : [Post]?
  
 
    var currentPosts : [Post]?

    var post: Post? {
        didSet {
            
        }
    }
    
    var searchController : UISearchController!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        self.searchController.searchBar.tintColor = UIColor.darkGray
        
   //     getDataRecentViewedPost()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        getDataRecentViewedPost()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        getDataRecentViewedPost()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
    func search(searchText : String  ) {
        currentPosts =  posts?.filter({ (post) -> Bool in
            post.title.lowercased().contains(searchText.lowercased())
        })
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil {
            search(searchText : searchBar.text!  )
            tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
        
    }
    
    
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchController.setShowsCancelButton(true, animated: true)
//    }
    
    
//
//    func storeData(savedForLaterInt : [Int]){
//        defaults?.set(savedForLaterInt, forKey: "savedForLaterInt")
//    }
//
//    func containRecentViewedPost(postId: Int) -> Bool {
//        let exists = recentlyViewdPost.contains(where: { (post) -> Bool in
//            if post.id == postId {
//                return true
//            } else {
//                return false
//            }
//        })
//        return exists
//    }
    
//    func getDataRecentViewedPost(){
//        let data = defaults?.value(forKey: "savedForLaterInt") as? [Int]
//        print("recent viewed post \(data)")
//        if data != nil{
//            for postId in data! {
//                for post in posts! {
//                    if postId == post.id{
//                        let exists = containRecentViewedPost(postId: postId)
//                        if exists != true {
//                            recentlyViewdPost.append(post)
//                        }
//                    }
//                }
//            }
//        } else {
//
//        }
//    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentPosts = []
        searchBar.text = ""
        tableView.reloadData()
    }
    
    
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellPost", for: indexPath) as? CellPost else { return CellPost() }
        let post = currentPosts?[indexPath.row]
        let title = String(htmlEncodedString:(post?.title)!)
        let contentLbl =  String(htmlEncodedString:(post?.excerpt)!)
        cell.updateCell(title: title,contentLbl: contentLbl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail1", sender: self)
    }
    
    
    func contain(post: Post) -> Bool{
        
        for recentPost in recentlyViewdPost {
            if recentPost.id == post.id{
                return true
            }
        }
        return false
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedPost = currentPosts![indexPath.row]
//            if let index = recentlyViewdInt.index(of: selectedPost.id) {
//
//            } else {
//                recentlyViewdInt.insert(selectedPost.id, at: 0)
//  //              HomeVC().storeData(savedForLaterInt: recentlyViewdInt)
//            }
            
//            let postContain = contain(post: selectedPost)
//            if postContain == false {
//                recentlyViewdPost.insert(selectedPost, at: 0)
//                isReload = false
//            }
            
            let postVC = segue.destination as? PostVC
            postVC?.post = selectedPost
            postVC?.posts =  self.posts
        }
        
        
        
    }
    
}























//        let siteURL = "https://islamexplored.org/wp-json/wp/v2"
//
//        let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: nil, search: searchText)
//
//
//        postRequest.fetchLastPosts(completionHandler: { posts, error in
//            if let newposts = posts {
//                DispatchQueue.main.async {
//                    self.posts = newposts
//                    self.tableView.reloadData()
//                }
//            }
//        })

//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
////        guard searchBar.text != "" else {
////            currentPosts = posts
////            tableView.reloadData()
////            return
////        }
////        currentPosts = posts?.filter({ (post) -> Bool in
////
////            print(currentPosts)
////            tableView.reloadData()
////            return true
////        })
//    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            currentPosts = postResults?.sorted(byKeyPath: "title", ascending: true )
//            tableView.reloadData()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//
//
//    }

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel")
//    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        if searchBar.text != nil {
//            searchFromDataBase(searchText : searchBar.text!  )
//        tableView.reloadData()
//            if posts?.count == 0 {
//                print("sorry we couldn't find any results")
//            }
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//
//
//    }



//    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange,
//                   replacementText text: String) -> Bool {
//        return true
//    }

//    func loadPosts(){
//        postResults = realm.objects(PostRealm.self)
//        tableView.reloadData()
//    }


