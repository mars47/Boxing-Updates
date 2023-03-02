//
//  TestView.swift
//  Boxing 247
//
//  Created by Omar on 23/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit

class LoadView: UIView {
    
    func configureView(height: CGFloat) {
        
        roundedCorners(radius: 12)
        //roundCorners(corners: .allCorners, radius: 12)
        center = CGPoint(x: deviceWidth/2, y: height/2)
    }
}
