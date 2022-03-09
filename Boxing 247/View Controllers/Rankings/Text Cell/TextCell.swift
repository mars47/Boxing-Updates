//
//  TextCell.swift
//  Boxing 247
//
//  Created by Omar on 11/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconHeight: NSLayoutConstraint!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let height: CGFloat = 52.5
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        icon.layer.cornerRadius = icon.frame.height / 2
    }

    func configureIcon(with segment: RankingsVC.Segment, belt: Belt) {
        
        if segment == .federation {
            
            let view: CowbellView = UIView.fromNib()
            let lb = belt.weightClass?.lb?.stringValue ?? ""
            view.configureLabel(text: lb + " lb")
            view.cowbellIcon.tintColor = UIColor(named: "pomegranate247")
            icon.image = view.asImage()
            icon.backgroundColor = UIColor.clear
            icon.tintColor = UIColor.clear
            iconWidth.constant = 38
            iconHeight.constant = 30
            titleLabel.text = belt.weightClass?.name
            subtitleLabel.text = belt.boxer?.name
        }
        
        else if segment == .weightDivision {
            
            icon.image = UIImage(systemName: "shield")
            icon.tintColor = UIColor.systemYellow
            icon.backgroundColor = updateBeltColour(icon, for: belt)
            iconWidth.constant = 47
            iconHeight.constant = 20
            titleLabel.text = belt.organisation?.shortName
            subtitleLabel.text = belt.boxer?.name
        }

        else { fatalError() }
    }
    
    func updateBeltColour(_ icon: UIImageView, for belt: Belt) -> UIColor {
        
        switch Organisation.Id(rawValue: belt.organisation!.identifierInt) {
            
        case .wbo:
            return burgundy
        case .wba:
            return UIColor.black
        case .wbc:
            return turquoise
        case .ibf:
            return UIColor.systemRed
        case .none:
            return UIColor.clear
        }
    }

}
