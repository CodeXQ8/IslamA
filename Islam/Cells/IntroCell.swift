//
//  IntroCell.swift
//  Islam Explored
//
//  Created by Nayef Alotaibi on 12/14/18.
//  Copyright © 2018 Islam. All rights reserved.
//

import UIKit

class IntroCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
  
    @IBOutlet weak var exceprtLbl: UILabel!
    
    
    func updateCell(titleLbl: String?, exceprtLbl : String?){
        
        self.titleLbl.text = "What is Islam?"
        self.exceprtLbl.text = "Islam is the name of the religion, or more properly the ‘way of life’, which God has revealed and which was practiced by all of the Prophets and Messengers of God that He sent to mankind including Moses and Jesus.  Even the name Islam stands out unique among other religions in that it means a state of being."
        
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
