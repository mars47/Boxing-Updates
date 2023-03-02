//
//  NavigationPanelVM.swift
//  Boxing 247
//
//  Created by Omar  on 07/04/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import Foundation
import UIKit

struct HelpMenuVM {
        
    let sections =  ["Help"]
    let rows = [
        ["About Us", "Send Feedback", "Share App", "Rate Us" ] 
        /* Add more array's for extra sections*/
    ]
    let icons = [
        [UIImage(systemName:"info.circle.fill"), UIImage(systemName:"envelope.fill"), UIImage(systemName:"square.and.arrow.up.fill"),  UIImage(systemName:"hand.thumbsup.fill")]
    ]
}
