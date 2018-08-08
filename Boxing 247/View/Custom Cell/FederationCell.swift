//
//  FederationCell.swift
//  Boxing 247
//
//  Created by Omar  on 06/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class FederationCell: UICollectionViewCell {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundHeight: NSLayoutConstraint!
    @IBOutlet weak var backgroundWidth: NSLayoutConstraint!
    @IBOutlet weak var clearPanelHeight: NSLayoutConstraint!
    @IBOutlet weak var clearPanelWidth: NSLayoutConstraint!
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
         widthConstraint.constant = screenWidth
        let ratio = self.bounds.size.width / self.bounds.size.height
        heightConstraint.constant = widthConstraint.constant / ratio
        
        backgroundHeight.constant = heightConstraint.constant
        backgroundWidth.constant = widthConstraint.constant
        
    }

}
