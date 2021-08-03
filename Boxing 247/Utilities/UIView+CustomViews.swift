//
//  UIView+CustomViews.swift
//  Boxing 247
//
//  Created by Omar on 30/07/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit

extension UIView {
    
     func noInternetView(yPosition: CGFloat) -> UIView {
        
        let noInternetViewInsets : CGFloat = 2 * 8
        let width = deviceWidth - noInternetViewInsets
        
        let noInternetView = UIView(frame: CGRect(x: noInternetViewInsets/2, y: yPosition, width: width, height: 50))
        
        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        shadowView.backgroundColor = pomegranate247
        shadowView.alpha = 0.7
        noInternetView.addSubview(shadowView)
        noInternetView.configureShadowAndRoundCorners(shadowBounds: shadowView, cornerRadius: 8)

        let imageView = UIImageView(frame: CGRect(x: 16, y: 12, width: 25, height: 25))
        imageView.image = UIImage(systemName: "exclamationmark.circle")
        imageView.tintColor = UIColor.white
        noInternetView.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 50, y: 12, width: width, height: 25))
        label.textColor = UIColor.white
        label.text = "No Internet Connection"
        noInternetView.addSubview(label)
            
        return noInternetView
    }
}
