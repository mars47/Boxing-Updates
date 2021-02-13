//
//  RankingCell.swift
//  Boxing 247
//
//  Created by Omar on 11/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconHeight: NSLayoutConstraint!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        icon.layer.cornerRadius = icon.frame.height / 2
    }

    func configureIcon(segment: Segment) {
        
        if segment == .federation {
            let view: CowbellView = UIView.fromNib()
            view.cowbellIcon.tintColor = UIColor(named: "pomegranate247")
            icon.image = view.asImage()
            icon.backgroundColor = UIColor.clear
            iconWidth.constant = 38
            iconHeight.constant = 30
        }
        
        else if segment == .weightDivision {
            icon.image = UIImage(systemName: "shield")
            icon.tintColor = UIColor.yellow
            icon.backgroundColor = UIColor.black
            iconWidth.constant = 47
            iconHeight.constant = 20
        }

        else { fatalError() }
    }
}
