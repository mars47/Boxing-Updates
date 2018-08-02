//
//  WeightDivisionCell.swift
//  Boxing 247
//
//  Created by Omar  on 01/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.bounds.size.width  = UIScreen.main.bounds.size.width
        self.bounds.size.height = (self.bounds.size.width / 4.498)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
