//
//  UIButtonDesignable.swift
//  Notes App
//
//  Created by Mohamed Skaik on 8/18/20.
//  Copyright © 2020 Mohamed Skaik. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonDesignable: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear
    @IBInspectable var shadowRadius: CGFloat = 0
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowOpacity: Float = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        //layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] //Top left and right
        
        //layer.maskedCorners = [.layerMinXMinYCorner] // top left
        //layer.maskedCorners = [.layerMinXMaxYCorner] // button left
        //layer.maskedCorners = [.layerMaxXMaxYCorner] //  button right
        //layer.maskedCorners = [.layerMaxXMinYCorner] // top right
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
    }

}
