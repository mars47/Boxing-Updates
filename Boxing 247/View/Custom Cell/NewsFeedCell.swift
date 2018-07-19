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
    weak var collectionView: UICollectionView!
    
    var viewModel: NewsFeedCellVM! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        
        DispatchQueue.main.async {
            
            if self.viewModel.image == nil { self.updateUI() }
            else { self.thumbnail.image = self.viewModel.image}
            
            self.pubDate.text = self.viewModel.article.pubDate
            
            self.title.preferredMaxLayoutWidth = (self.superview?.bounds.size.width)! / 1.0923
            self.title.text = self.viewModel.article.title
            self.content.text = self.viewModel.article.description;
            
            //self.content.preferredMaxLayoutWidth = (self.superview?.bounds.size.width)! / 1.0923
            self.content.preferredMaxLayoutWidth = self.collectionView.subviews[0].bounds.width - 5
            print(self.collectionView.subviews[0].bounds.width)
            
            //print((self.superview?.bounds.size.width)!)
            
            //print("'\(self.viewModel.article.description)'")
            
            self.thumbnail.contentMode = .scaleAspectFill
            self.thumbnail.clipsToBounds = true
        }
        
    }
    
    func assignViewModel(viewModel: NewsFeedCellVM) {
        self.viewModel = viewModel
    }
}
