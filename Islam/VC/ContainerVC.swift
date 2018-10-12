//
//  ContainerVC.swift
//  Islam
//
//  Created by Nayef Alotaibi on 10/5/18.
//  Copyright © 2018 Islam. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {


    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewF: UICollectionView!
    
        var pageArray = Array<Page>()
        var pages = Array<Page>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPages()

    
        collectionViewA.delegate = self
        collectionViewA.dataSource = self
        collectionViewA.reloadData()
        
        collectionViewF.delegate = self
        collectionViewF.dataSource = self
        collectionViewF.reloadData()

    }

    func fetchPages() {
        let siteURL = "https://islamexplored.org/wp-json/wp/v2"
        
        let postRequest = PostRequest(url:siteURL, page:1, perPage:100)
        postRequest.fetchpages(completionHandler: { pages, error in
            if let newPages = pages {
                DispatchQueue.main.async {
                    self.pageArray = newPages
                    for page in self.pageArray {
                        if page.id == 1019 ||   page.id == 1326 || page.id == 1066{
                            self.pages.append(page)
                            print(self.pages.count)
                        }
                    }
                    self.collectionViewA.reloadData()
                    self.collectionViewF.reloadData()
                }
            }
        })
        
    }

}
extension ContainerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewA {
            return pages.count // Replace with count of your data for collectionViewA
        }
        return pages.count
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewA {
            guard let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return CollectionViewCell() }
            
            let titleLbl = String(htmlEncodedString:pages[indexPath.row].title)
            let exceprtLbl = String(htmlEncodedString:pages[indexPath.row].excerpt)
            
            cell.updateCell(titleLbl: titleLbl, exceprtLbl: exceprtLbl)

            
            return cell
        } else {
            
                guard let cell : CollectionViewCellF = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellF", for: indexPath) as? CollectionViewCellF else { return CollectionViewCellF() }
                
                let titleLbl = String(htmlEncodedString:pages[indexPath.row].title)
                let exceprtLbl = String(htmlEncodedString:pages[indexPath.row].excerpt)
                
                cell.updateCell(titleLbl: titleLbl, exceprtLbl: exceprtLbl)

                
                return cell
            }
    
    }
    

    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        self.indexCell = indexPath.item
    //        performSegue(withIdentifier: "songListSegue", sender: self)
    //
    //    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let songListVC = segue.destination as? SongListVC {
    //            songListVC.indexCell = self.indexCell
    //            songListVC.reciter = reciters?[indexCell]
    //        }
    
    //}
    
}

