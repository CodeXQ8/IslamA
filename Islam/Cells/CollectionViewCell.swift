//
//  CollectionViewCell.swift
//  Islam
//
//  Created by Nayef Alotaibi on 10/6/18.
//  Copyright © 2018 Islam. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var exceprtLbl: UILabel!
    
    func updateCell(titleLbl: String, exceprtLbl : String){
        
        self.titleLbl.text = titleLbl
        self.exceprtLbl.text = exceprtLbl
        
    }
    
    
    func updateLayout(){
        
    }
    
    
    @IBInspectable var cornerRaduis : CGFloat = 0.0 {
        
        didSet {
            self.layer.cornerRadius = cornerRaduis
        }
    }
    
    @IBInspectable var shadowRadius : CGFloat = 0.0 {
        
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0.0 {
        
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0.0 {
        
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var bordercolor : CGFloat = 0.0 {
        
        didSet {
            self.layer.borderColor = UIColor.lightGray.cgColor     }
    }
    
    
}


