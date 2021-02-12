//
//  WeightDivisionReusableView.swift
//  Boxing 247
//
//  Created by Omar on 18/12/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class WeightDivisionReusableView: UICollectionReusableView {
    

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var thumbnailWidth: NSLayoutConstraint!
    @IBOutlet weak var thumbnailHeight: NSLayoutConstraint!
    
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewBottom: NSLayoutConstraint!
    @IBOutlet weak var thumbnail: UIImageView!

    @IBOutlet weak var gradientViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        let screenWidth = UIScreen.main.bounds.size.width

        thumbnailWidth.constant = screenWidth
        thumbnailHeight.constant = thumbnailWidth.constant / 2.48
        thumbnail.contentMode = .scaleAspectFill
    }
    
}
