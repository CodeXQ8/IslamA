//
//  cellPost.swift
//  Islam
//
//  Created by Nayef Alotaibi on 9/2/18.
//  Copyright © 2018 Nayef Alotaibi. All rights reserved.
//


import UIKit

@IBDesignable
class CellPost: UITableViewCell {
    

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!

    @IBOutlet weak var imageViewCell: UIImageView!
    
    func updateCell(title : String, contentLbl: String,ImageView: String?){
        self.titleLbl.text = title
        self.contentLbl.text = contentLbl
        if ImageView != nil {
        self.imageViewCell.image = UIImage(named: ImageView! )
        } else {
            
            print("no image")
        }
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
