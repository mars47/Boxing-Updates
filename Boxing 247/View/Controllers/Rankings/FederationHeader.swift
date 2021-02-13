//
//  FederationReusableView.swift
//  Boxing 247
//
//  Created by Omar on 30/12/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class FederationHeader: RankingsHeader {
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var clearPanel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        let screenWidth = UIScreen.main.bounds.size.width
        width.constant = screenWidth
        height.constant = width.constant / 2
    }
    
    func roundPanelCorners() {
        clearPanel.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 25)
    }
    
}
