//
//  TextCell.swift
//  Boxing 247
//
//  Created by Omar on 11/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {
    
    @IBOutlet weak var beltIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        beltIcon.layer.cornerRadius = beltIcon.frame.height / 2
    }
}
