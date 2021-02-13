//
//  NewsFeedCell.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {
    
    // MARK: - Properties -
    
    @IBOutlet weak var pubDate: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var topPanelStackView: UIStackView?
    @IBOutlet weak var mainStackView: UIStackView?

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false
//    }
    
    // MARK: - Configuration -
    
    func configureCell(with article: Article) {
        
        DispatchQueue.main.async {
                        
            self.pubDate.text = article.timeAgo
            self.title.text = article.title
            self.thumbnail.contentMode = .scaleAspectFill
            self.thumbnail.clipsToBounds = true

            //self.author.text = "Published by \(article.author)"
            //self.content.text = article.description;
        }
        
        configureShadowAndRoundCorners(shadowBounds: contentView)
    }
    

    
//    func setDynamicConstraints() {
//
//        let deviceSize = UIScreen.main.bounds.size
//        let cellWidthWithInsets = deviceSize.width - (2 * 20)
//        self.widthConstraint.constant = cellWidthWithInsets
//        self.topPanelStackView?.spacing = cellWidthWithInsets - (12 + 80 + 84 + 4)
//    }
    
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
