//
//  RankingsHeader.swift
//  ContactsLBTA
//
//  Created by Omar on 01/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

class WeightDivisionHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var button: UIButton!
         
    func configureButtonImage(isExpanded: Bool) {
        
        button.setImage(UIImage(systemName: isExpanded ? "minus.circle" : "plus.circle")!, for: .normal)
    }
}
