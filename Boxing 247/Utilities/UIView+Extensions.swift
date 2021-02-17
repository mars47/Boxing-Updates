//
//  NibView.swift
//  Boxing 247
//
//  Created by Omar on 09/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

extension UIView {

    /* Instantiates custom UIView from nib */
    class func fromNib<T: UIView>() -> T {
        /** How to use: let myCustomView: CustomView = UIView.fromNib() */
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    /* Converts UIView to UIImage */
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func configureShadowAndRoundCorners(shadowBounds: UIView) {
        
            shadowBounds.layer.cornerRadius = 12
            shadowBounds.layer.borderWidth = 1.0
            shadowBounds.layer.borderColor = UIColor.clear.cgColor
            shadowBounds.layer.masksToBounds = true

            layer.shadowColor = dark247.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0) // 0, 2
            layer.shadowRadius = 6 // 6
            layer.shadowOpacity = 1 // 1
            layer.masksToBounds = false
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadowBounds.layer.cornerRadius).cgPath
            layer.backgroundColor = UIColor.clear.cgColor
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        /**  how to use: view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 12) */
       
        let bounds = self.bounds
        let mask = CAShapeLayer()
        mask.masksToBounds = false
        mask.shadowOpacity = 1
        mask.shadowRadius = 3
        mask.shadowOffset = CGSize(width: 0, height: 0)
        mask.shadowColor = UIColor.yellow.cgColor
        
        mask.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
    
         layer.mask = mask
     }
    
    func blink() {
        
        self.alpha = 0.2
        UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear], animations: {self.alpha = 1.0}, completion: nil)
    }
}
