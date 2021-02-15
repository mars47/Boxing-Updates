//
//  RankingsVM.swift
//  Boxing 247
//
//  Created by Omar  on 13/02/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import Foundation
import UIKit

class RankingsVM {
    
    // MARK: - Properties

    var banners = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3"), UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3")]
    let belts = [UIImage(named: "wbo belt"), UIImage(named: "wba belt"), UIImage(named: "wbc belt")]
    let logos = [UIImage(named: "wbo logo"), UIImage(named: "wba logo"), UIImage(named: "wbc logo")]
    var sectionStates = [ [Bool](), [Bool]() ]
    
    // MARK: - Public Methods

    func configureSectionStates() {
        
        for _ in banners { sectionStates[0].append(true) }
        for _ in belts { sectionStates[1].append(true) }
    }
}
