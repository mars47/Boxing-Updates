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
    
    let test = "STRING"
    
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
            self.title.text = self.viewModel.article.title
            self.content.text = self.viewModel.article.description;
            
            print("'\(self.viewModel.article.description)'")
            
            self.thumbnail.contentMode = .scaleAspectFill
            self.thumbnail.clipsToBounds = true
        }
        
    }
    
    func assignViewModel(viewModel: NewsFeedCellVM) {
        self.viewModel = viewModel
    }
}
