//
//  NibView.swift
//  Boxing 247
//
//  Created by Omar on 09/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

//class NibView: UIView {
//    var view: UIView!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        // Setup view from .xib file
//        xibSetup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        // Setup view from .xib file
//        xibSetup()
//    }
//}
//private extension NibView {
//
//    func xibSetup() {
//        backgroundColor = UIColor.clear
//        view = loadNib()
//        // use bounds not frame or it'll be offset
//        view.frame = bounds
//        // Adding custom subview on top of our view
//        addSubview(view)
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
//                                                      options: [],
//                                                      metrics: nil,
//                                                      views: ["childView": view!]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
//                                                      options: [],
//                                                      metrics: nil,
//                                                      views: ["childView": view!]))
//    }
//}

extension UIView {
    /** Loads instance from nib with the same name. */
//    func loadNib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
//        let nibName = type(of: self).description().components(separatedBy: ".").last!
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as! UIView
//    }
    
    class func fromNib<T: UIView>() -> T {
        
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
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
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, altBounds: CGRect?) {
        //cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 12)
        let bounds = altBounds == nil ? self.bounds : altBounds!
        
        
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
