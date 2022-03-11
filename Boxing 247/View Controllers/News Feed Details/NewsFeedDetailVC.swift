//
//  NewsFeedDetailVC.swift
//  Boxing 247
//
//  Created by Omar on 16/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import SafariServices
import UIKit

class NewsFeedDetailVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var scrollview2: UIScrollView!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet weak var enlargeButton: UIButton!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var backButton: UINavigationItem!
    
    var newsArticle: NewsArticle!
    var selectedSegment: NewsFeedVC.Segment!
    var updateViewModel: ( () -> Void)?

    // MARK: - Configuration

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(data: newsArticle.thumbnail ?? Data())
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        imageView.isUserInteractionEnabled = true
        
        websiteButton.setAttributedTitle(" View Website".underLined, for: .normal)
        websiteButton.roundCorners(corners: .allCorners, radius: 8)
        bookmarkButton.isSelected = newsArticle.isBookmarked
        
        timeAgoLabel.text =  newsArticle.pubDate == nil ? "n/a" : Date().timeAgoSinceDate(newsArticle.pubDate!)
        titleLabel.text = "\(newsArticle.title ?? "")"
        descriptionLabel.text = newsArticle?.content
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let bar = navigationController?.navigationBar
        bar?.tintColor = UIColor.white
        bar?.prefersLargeTitles = false
        
        bar?.setNeedsLayout()
        bar?.layoutIfNeeded()
        bar?.setNeedsDisplay()
    }
        
    // MARK: - Events

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "NewsFeedDetailShowPopOverVC", sender: newsArticle)
    }
    
    @IBAction func websiteButtonPressed(_ sender: Any) {
        
        guard
            let urlString = newsArticle.link,
            let url = URL(string: urlString)
        else {
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: false)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["Check out this free app called 'Boxing Updates' to keep updated with the latest boxing news!"], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func enlargeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "NewsFeedDetailShowPopOverVC", sender: newsArticle)
    }
    
    @IBAction func bookmarkButtonPressed(_ sender: Any) {
        
        guard let newsArticle = newsArticle else {
            presentUIAlert(title: "Something happened", message: "Unable to bookmark item")
            return
        }
        
        switch true {
        
        case bookmarkButton.isSelected:
            presentUIAlert(title: "Warning", message: "Are you sure you want to remove article from saved items?")
            
        case !bookmarkButton.isSelected:
            newsArticle.isBookmarked = !bookmarkButton.isSelected
            bookmarkButton.isSelected = !bookmarkButton.isSelected
            
        default: return
            
        }
        
        SaveUtility.saveChanges()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch true  {
        
        case segue.identifier == "NewsFeedDetailShowPopOverVC":
            guard
                let article = sender as? NewsArticle,
                let imageData = article.thumbnail,
                let viewController = segue.destination as? ImagePopOverVC
            else { return }
            viewController.image = UIImage(data: imageData)
                
        default:
            return
        }
    }
    
}
    
private extension NewsFeedDetailVC {
    
    func presentUIAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .label
        
        if newsArticle == nil {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        } else {
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ [self] handler in
                bookmarkButton.isSelected = true
                newsArticle.isBookmarked = true
            })
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) { [self] handler in
                bookmarkButton.isSelected = false
                newsArticle.isBookmarked = false
                
                if selectedSegment == .bookmarked {
                    updateViewModel?()
                }
            })
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

//https://medium.com/@Anantha1992/stretchable-header-view-in-scrollview-swift-5-ios-7c4bb689ac49
