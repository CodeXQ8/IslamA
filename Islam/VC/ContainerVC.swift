//
//  ContainerVC.swift
//  Islam
//
//  Created by Nayef Alotaibi on 10/5/18.
//  Copyright © 2018 Islam. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ContainerVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return CollectionViewCell() }
        
        let titleLbl = "house"
        let exceprtLbl = "$3,540,000 "
        
        cell.updateCell(titleLbl: titleLbl, exceprtLbl: exceprtLbl)
        cell.layer.shadowRadius = 5
        cell.layer.shadowOffset = CGSize(width: 0, height: 0 )
        cell.layer.shadowOpacity = 0.1
        
        return cell
        
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

