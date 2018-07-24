//
//  NewsFeedCell.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {
    
    @IBOutlet weak var pubDate: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthConstraint.constant = screenWidth - (2 * 10)
    }
    
    var viewModel: NewsFeedCellVM! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.3
        
        DispatchQueue.main.async {
            
            if self.viewModel.image == nil { self.updateUI() } // a hack to ensure that a cell is always returned with a UIImage when given a viewModel
            else { self.thumbnail.image = self.viewModel.image }
            
            self.pubDate.text = self.viewModel.article.pubDate
            self.title.text = self.viewModel.article.title
            self.content.text = self.viewModel.article.description;
            self.thumbnail.contentMode = .scaleAspectFill
            self.thumbnail.clipsToBounds = true
        }
    }
}

//self.thumbnailWidth.constant = UIScreen.main.bounds.width
//self.thumbnailHeight.constant = self.collectionView.subviews[0].bounds.height / 1.7
// self.title.preferredMaxLayoutWidth = (self.superview?.bounds.size.width)! / 1.0923



