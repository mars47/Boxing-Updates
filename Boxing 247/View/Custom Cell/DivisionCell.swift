//
//  DivisionCell.swift
//  Boxing 247
//
//  Created by Omar  on 06/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class DivisionCell: UICollectionViewCell {


    @IBOutlet weak var clearPanelHeight: NSLayoutConstraint!
    @IBOutlet weak var clearPanelWidth: NSLayoutConstraint!
    @IBOutlet weak var blurViewHeight: NSLayoutConstraint!
    @IBOutlet weak var blurViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    @IBOutlet weak var thumbnailWidth: NSLayoutConstraint!
    
    @IBOutlet weak var boundsView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = test247
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width

        widthConstraint.constant = screenWidth

        let ratio = self.bounds.size.width / self.bounds.size.height

        
        heightConstraint.constant = widthConstraint.constant / ratio
        
        
        thumbnailHeight.constant = heightConstraint.constant
        thumbnailWidth.constant = widthConstraint.constant
        


        clearPanelWidth.constant =  widthConstraint.constant / 3.902
        blurViewWidth.constant = clearPanelWidth.constant
    
        clearPanelHeight.constant = heightConstraint.constant / 2
        blurViewHeight.constant = heightConstraint.constant / 2
        
        self.backgroundColor = UIColor.white
    }

}
