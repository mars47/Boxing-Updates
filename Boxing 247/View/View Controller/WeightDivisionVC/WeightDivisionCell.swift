//
//  WeightDivisionCell.swift
//  Boxing 247
//
//  Created by Omar  on 01/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionCell: UITableViewCell {

    @IBOutlet weak var divisionTitle: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //thumbnail.layer.borderWidth = 0.5
        //thumbnail.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = test247
        //divisionTitle.layer.borderWidth = 0.3
        //divisionTitle.layer.borderColor = UIColor.lightGray.cgColor
       // divisionTitle.textColor = dark247
       // divisionTitle.backgroundColor = red247
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5)) //t l b r
    }
    
}
