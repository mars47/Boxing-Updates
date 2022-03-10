//
//  RankingsHeader.swift
//  ContactsLBTA
//
//  Created by Omar on 01/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

class WeightDivisionHeader: UITableViewHeaderFooterView {
    

    @IBOutlet weak var lb: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
         
    func configureButtonImage(isExpanded: Bool) {
        
        button.setImage(UIImage(systemName: isExpanded ? "minus.circle" : "plus.circle")!, for: .normal)
    }
    
    func configure(with weightclass: WeightClass?) {
        
        if let name = weightclass?.name?.lowercased() {
            backgroundImageView.image = UIImage(named: name + "_banner")
        }
        
        title.text = weightclass?.name
        lb.text = (weightclass?.lb?.stringValue ?? "") + " LBS"
    }
}
