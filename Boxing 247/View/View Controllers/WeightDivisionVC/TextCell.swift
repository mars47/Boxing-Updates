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
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        beltIcon.layer.cornerRadius = beltIcon.frame.height / 2
        
        contentView.layer.cornerRadius = 6.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = white247.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0) // 0, 2
        layer.shadowRadius = 6 // 6
        layer.shadowOpacity = 1 // 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 1
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        //layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
