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
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var author: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var viewModel: NewsFeedCellVM! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {

        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        DispatchQueue.main.async {
            #warning("needs refactoring")
            
            if self.viewModel.image == nil { self.updateUI() } // a hack to ensure that a cell is always returned with a UIImage when given a viewModel
            else { self.thumbnail.image = self.viewModel.image }
            
            self.author.text = "Published by \(self.viewModel.article.author)"
            self.pubDate.text = self.viewModel.article.timeAgo
            self.title.text = self.viewModel.article.title
            self.content.text = self.viewModel.article.description;
            self.thumbnail.contentMode = .scaleAspectFill
            self.thumbnail.clipsToBounds = true
            
            let deviceSize = UIScreen.main.bounds.size
            self.widthConstraint.constant = deviceSize.width - (2 * 12);
        }
    }
    
    func calculateHeightForLable(text:String, font:UIFont, width:CGFloat, lines:Int) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines = lines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}

//self.thumbnailWidth.constant = UIScreen.main.bounds.width
//self.thumbnailHeight.constant = self.collectionView.subviews[0].bounds.height / 1.7
// self.title.preferredMaxLayoutWidth = (self.superview?.bounds.size.width)! / 1.0923
//        let width = widthConstraint.constant
//        heightConstraint.constant = widthConstraint.constant / 1.5
//        let height = heightConstraint.constant
//        print(width); print(height)


