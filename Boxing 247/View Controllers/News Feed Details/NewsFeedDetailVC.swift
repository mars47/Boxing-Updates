//
//  NewsFeedDetailVC.swift
//  Boxing 247
//
//  Created by Omar on 16/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

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
    
    var newsArticle : NewsArticle!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let bar = navigationController?.navigationBar
        bar?.tintColor = UIColor.white
        bar?.prefersLargeTitles = false
        
        bar?.setNeedsLayout()
        bar?.layoutIfNeeded()
        bar?.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(data: newsArticle.thumbnail ?? Data())
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        websiteButton.setAttributedTitle(" View Website".underLined, for: .normal)
        websiteButton.roundCorners(corners: .allCorners, radius: 8)
        
        titleLabel.text = "\(newsArticle.title ?? "")"
        //titleLabel.roundCorners(corners: .allCorners, radius: 4)
        descriptionLabel.text = newsArticle?.content

        //= "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"

//        guard let url = URL(string: "https://stackoverflow.com") else { return }
//        UIApplication.shared.open(url)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "NewsFeedDetailShowPopOverVC", sender: newsArticle)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: ["Check out this free app called 'Boxing Updates' to keep updated with the latest boxing news!"], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func bookmarkButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func enlargeButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "NewsFeedDetailShowPopOverVC", sender: newsArticle)
    }
    
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


//https://medium.com/@Anantha1992/stretchable-header-view-in-scrollview-swift-5-ios-7c4bb689ac49
