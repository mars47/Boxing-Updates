//
//  CustomSegmentedControl.swift
//  Boxing 247
//
//  Created by Omar  on 05/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
// https://www.sep.com/sep-blog/2017/04/28/custom-uisegmentedcontrol-swift-tutorial/

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    //UIColor(red: 19/255, green: 59/255, blue: 85/255, alpha: 0.5)
    let selectedBackgroundColor = grey247
    var sortedViews: [UIView]!
    var currentIndex: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        sortedViews = self.subviews.sorted(by:{$0.frame.origin.x < $1.frame.origin.x})
        changeSelectedIndex(to: currentIndex)
        self.tintColor = UIColor.black
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        let selectedAttributes : [NSAttributedStringKey : NSObject] = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                                                       NSAttributedStringKey.font:  UIFont(name: "PingFangSC-Regular", size: 13.0)!]
        let unselectedAttributes : [NSAttributedStringKey : NSObject] = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                                         NSAttributedStringKey.font:  UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)!]

        self.setTitleTextAttributes(unselectedAttributes, for: .normal)
        self.setTitleTextAttributes(selectedAttributes, for: .selected)

    }

    func changeSelectedIndex(to newIndex: Int) {
        sortedViews[currentIndex].backgroundColor = UIColor.clear
        currentIndex = newIndex
        self.selectedSegmentIndex = UISegmentedControlNoSegment
        sortedViews[currentIndex].backgroundColor = selectedBackgroundColor
    }
}
