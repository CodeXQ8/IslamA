    //
    //  HomeVC.swift
    //  Islam
    //
    //  Created by Nayef Alotaibi on 10/4/18.
    //  Copyright © 2018 Islam. All rights reserved.
    //
    
    import UIKit
    import SideMenu
    
    class FQA_sVC: UIViewController{
        
        @IBOutlet weak var tableView: UITableView!
        
        var postsArticles = Array<Post>()
        var postsFqa = Array<Post>()
        var postsMisconceptions = Array<Post>()
        var posts = Array<Post>()
        
        let articles = 35
        let fqa = 36
        let misconceptions = 37
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // navigationSetUp()
            fetchAllPosts()
            tableView.delegate = self
            tableView.dataSource = self
            self.tableView.reloadData()
            
            
            SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
            SideMenuManager.default.menuFadeStatusBar = false
            
        }
        
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }
        
        
        
        
        func navigationSetUp(){
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        
        func fetchAllPosts(){
            fetchArticles()
            fetchFQA()
            fetchMisconceptions()
        }
        
        func fetchArticles() {
            let siteURL = "https://islamexplored.org/wp-json/wp/v2"
            
            let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: articles)
            postRequest.fetchLastPosts(completionHandler: { posts, error in
                if let newposts = posts {
                    DispatchQueue.main.async {
                        self.postsArticles = newposts
                        self.tableView.reloadData()
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
        
        func fetchMisconceptions() {
            let siteURL = "https://islamexplored.org/wp-json/wp/v2"

            let postRequest = PostRequest(url:siteURL, page:1, perPage:100, categories: misconceptions)
            postRequest.fetchLastPosts(completionHandler: { posts, error in
                if let newpostsM = posts {
                    DispatchQueue.main.async {
                        self.postsMisconceptions = newpostsM
                        self.tableView.reloadData()
                    }
                }
            })

        }
  }
    
    //                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
    
    extension FQA_sVC: UITableViewDelegate, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return postsFqa.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellPost", for: indexPath) as? CellPost else { return CellPost() }
            
            let post = postsFqa[indexPath.row]
            let title = String(htmlEncodedString:post.title)
            let contentLbl = String(htmlEncodedString:post.excerpt)
            cell.updateCell(title: title,contentLbl: contentLbl)
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showDetail", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedPost = postsFqa[indexPath.row]
                let postVC = segue.destination as? PostVC
                postVC?.post = selectedPost
                postVC?.index = indexPath.row
            }
            
            let SearchVC = segue.destination as? SearchVC
            SearchVC?.posts = postsFqa + postsArticles + postsMisconceptions
            
        }
        
    }
    
    
  
