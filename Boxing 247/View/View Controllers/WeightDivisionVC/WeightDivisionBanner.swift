//
//  WeightDivisionBanner.swift
//  Boxing 247
//
//  Created by Omar on 10/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class WeightDivisionBanner: UIView {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    @IBOutlet weak var thumbnailWidth: NSLayoutConstraint!
    
    @IBOutlet weak var colouredPanel: UIView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var divisionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        //self.layer.borderColor = UIColor.lightGray.cgColor
        //self.layer.borderWidth = 0.5
        
        let screenWidth = UIScreen.main.bounds.size.width

        thumbnailWidth.constant = screenWidth - 32
        thumbnailHeight.constant = thumbnailWidth.constant / 4.507
        thumbnail.contentMode = .scaleAspectFill
        layer.masksToBounds = true
    }
    
    @IBAction func expandButtonClicked(_ sender: Any) {
        
        expandButton.blink()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }

}
