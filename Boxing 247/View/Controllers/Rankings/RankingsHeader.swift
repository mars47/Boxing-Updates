//
//  RankingsHeader.swift
//  ContactsLBTA
//
//  Created by Omar on 01/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class RankingsHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var button: UIButton!
         
    func configureButtonImage(isExpanded: Bool) {
        
        button.setImage(UIImage(systemName: isExpanded ? "minus.circle" : "plus.circle")!, for: .normal)
    }
}
