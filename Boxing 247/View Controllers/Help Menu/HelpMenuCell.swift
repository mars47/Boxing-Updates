//
//  PanelCell.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class HelpMenuCell: UITableViewCell {
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var topPanel: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = dark247
       
        let bgColorView = UIView()
        bgColorView.backgroundColor = dark247
        self.selectedBackgroundView = bgColorView
        
        icon.contentMode = .scaleAspectFill
       // icon.clipsToBounds = true
    }
    
    func configureCell(with viewModel: HelpMenuVM, and indexPath: IndexPath) {
        
        icon.image = viewModel.icons[indexPath.section][indexPath.row]!
        pageTitle.text = viewModel.rows[indexPath.section][indexPath.row]
        
    }
}
