//
//  DeisgnableButton.swift
//  Islam
//
//  Created by Nayef Alotaibi on 10/4/18.
//  Copyright © 2018 Islam. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    
    
    @IBInspectable var cornerRadius : CGFloat = 0.0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
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
    
}
