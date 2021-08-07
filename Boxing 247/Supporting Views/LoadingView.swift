//
//  ProgressView.swift
//  Boxing 247
//
//  Created by Omar on 06/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    func configureView() {
        
        let rootSubview = UIView(frame: CGRect(x: 0, y: -45, width: bounds.width, height: bounds.height))
        rootSubview.backgroundColor = base247
        rootSubview.roundCorners(corners: .allCorners, radius: 12)
        insertSubview(rootSubview, at: 0)
        center = CGPoint(x: deviceWidth/2, y: deviceHeight/2 - 100)
    }
}
