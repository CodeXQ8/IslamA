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
        
        self.definesPresentationContext = false
        
        
       // uisearchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
      print("1")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedPost = posts![indexPath.row]
            
            let postVC = segue.destination as? PostVC
            postVC?.post = selectedPost
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


