//
//  UIImageDesignable.swift
//  Notes App
//
//  Created by Mohamed Skaik on 29/10/2020.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

@IBDesignable
class UIImageDesignable: UIImageView {
    
    @IBInspectable var bgColor: UIColor = UIColor.clear
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.black
    
    @IBInspectable var shadowRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor = UIColor.gray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowOpacity: Float = 0
    
    @IBInspectable var flipInRTL: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.backgroundColor = bgColor.cgColor
        
        layer.cornerRadius = cornerRadius
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        
        if flipInRTL {
            if L102Language.currentAppleLanguage().elementsEqual("ar"){
                if let _img = image {
                    image =  _img.imageFlippedForRightToLeftLayoutDirection()
                }
            }
        }
    }
}
