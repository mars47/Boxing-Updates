//
//  FederationReusableView.swift
//  Boxing 247
//
//  Created by Omar on 30/12/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class FederationReusableView: UICollectionReusableView {
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        let screenWidth = UIScreen.main.bounds.size.width
        width.constant = screenWidth
        height.constant = width.constant / 2
    }
    
}
