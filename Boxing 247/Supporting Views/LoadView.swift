//
//  TestView.swift
//  Boxing 247
//
//  Created by Omar on 23/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit

class LoadView: UIView {
    
    func configureView() {
        
        roundCorners(corners: .allCorners, radius: 12)
        center = CGPoint(x: deviceWidth/2, y: deviceHeight/2 )
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
