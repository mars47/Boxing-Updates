//
//  NewsFeedCell.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var pubDate: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var mainStackView: UIStackView?
    
    // MARK: - Configuration
    
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
