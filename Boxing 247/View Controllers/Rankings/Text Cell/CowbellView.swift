//
//  CowbellView.swift
//  Boxing 247
//
//  Created by Omar on 26/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

class CowbellView: UIView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cowbellIcon: UIImageView!
    
    func configureLabel(text: String) {
        label.text = text
    }
}

