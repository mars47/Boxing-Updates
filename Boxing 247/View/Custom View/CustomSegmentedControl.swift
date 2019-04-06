//
//  CustomSegmentedControl.swift
//  Boxing 247
//
//  Created by Omar  on 05/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//  https://www.sep.com/sep-blog/2017/04/28/custom-uisegmentedcontrol-swift-tutorial/

import UIKit

class CustomSegmentedControl: UISegmentedControl {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    func configure() {


        let selectedAttributes : [NSAttributedString.Key : NSObject] = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                       NSAttributedString.Key.font:  UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)!]
        
        let unselectedAttributes : [NSAttributedString.Key : NSObject] = [NSAttributedString.Key.foregroundColor: grey247,
                                                                         NSAttributedString.Key.font:  UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)!]
        
        self.setTitleTextAttributes(selectedAttributes, for: .selected)
        self.setTitleTextAttributes(unselectedAttributes, for: .normal)
        
        //let state = self.titleTextAttributes(for: .selected)
        //print("state: \(state!)")
        

    }
}
