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
    @IBOutlet weak var bookmarkButton: UIButton!
   
    var newsArticle : NewsArticle?
    var presentUIAlert : ( (String, String, ((Bool) -> Void )?) -> Void)?
    
    // MARK: - Configuration
    
    func configureCell(with article: NewsArticle) {
        
        newsArticle = article
        
        DispatchQueue.main.async { [self] in
                        
            pubDate.text = article.timeAgo
            title.text = article.title
            bookmarkButton.isSelected = article.isBookmarked

            thumbnail.contentMode = .scaleAspectFill
            thumbnail.clipsToBounds = true

            //self.author.text = "Published by \(article.author)"
            //self.content.text = article.description;
        }
        
        configureShadowAndRoundCorners(shadowBounds: contentView)
    }
    
    @IBAction func bookmarkNewsArticle(_ sender: Any) {
        
        guard let newsArticle = newsArticle else {
            presentUIAlert?("Something happened", "Unable to bookmark item", nil)
            return
        }
        
        if bookmarkButton.isSelected {
            
            presentUIAlert?("Warning", "Are you sure you want to remove article from saved items?") { isActionCancelled in
                self.bookmarkButton.isSelected = isActionCancelled
            }
        }
            
        newsArticle.isBookmarked = !bookmarkButton.isSelected
        bookmarkButton.isSelected = !bookmarkButton.isSelected
        SaveUtility.saveChanges()
    }
    
    static func calculateHeightForLabel(text:String, font:UIFont, width:CGFloat, lines:Int) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines = lines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}
