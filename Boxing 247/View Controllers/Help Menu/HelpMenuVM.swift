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
        
    let sections =  ["Latest", "Boxing", "Community", "Help"]
    let rows = [
        ["News", "Fight Schedule", "Saved Articles"],
        ["Current Champions", "Weight Divisions"],
        ["Dashboard", "Messages", "Polls"],
        ["Contact Us", "Settings"]
    ]
    let icons = [[UIImage(named:"newsIcon"), UIImage(named:"calenderIcon"), UIImage(named:"downloadIcon")], [UIImage(named:"champIcon"), UIImage(named:"divisionsIcon")], [UIImage(named:"dashboardIcon"), UIImage(named:"messageIcon"), UIImage(named:"pollIcon")], [UIImage(named:"contactIcon"), UIImage(named:"settingsIcon")]]
}
