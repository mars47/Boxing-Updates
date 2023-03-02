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
    
    typealias UIAlertCompletion = ( (Bool) -> Void )?
    typealias Completion = ( () -> Void )

    var presentUIAlert : ( (String, String, UIAlertCompletion) -> Void)?
    var presentShareController : ( () -> Void )?
    var presentImagePopoverController :  ( (Completion?) -> Void )?

    // MARK: - Configuration
    
    func configureCell(with article: NewsArticle) {
        
        newsArticle = article
        
        pubDate.text = article.pubDate == nil ? "n/a" : Date().timeAgoSinceDate(article.pubDate!)
        title.text = article.title
        bookmarkButton.isSelected = article.isBookmarked
        
        if let imageData = article.thumbnail  {
            thumbnail.image = UIImage(data: imageData)
        }
        
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        configureShadowAndRoundCorners(shadowBounds: contentView, cornerRadius: nil)
    }
    
    @IBAction func bookmarkNewsArticle(_ sender: Any) {
        
        guard let newsArticle = newsArticle else {
            presentUIAlert?("Something happened", "Unable to bookmark item", nil)
            return
        }
        
        if bookmarkButton.isSelected {
            
            presentUIAlert?("Warning", "Are you sure you want to remove article from saved items?") { [self] isActionCancelled in
                
                bookmarkButton.isSelected = isActionCancelled
                newsArticle.isBookmarked = isActionCancelled
            }
            
        } else {
            newsArticle.isBookmarked = !bookmarkButton.isSelected
            bookmarkButton.isSelected = !bookmarkButton.isSelected
        }
        
        SaveUtility.saveChanges()
    }
    
    
    @IBAction func enlargeImageButtonPressed(_ sender: Any) {
        presentImagePopoverController?(nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        presentShareController?()
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
