//
//  NewsFeedVM.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedVM: NSObject {
    
    // MARK: - Properties
    
    var reloadCollectionView : ( () -> Void)?
    let url = URL(string: "https://bit.ly/2tZmM0E")
    var articles: [Article] = []
    let networkManager : NetworkManager
        
    // MARK: - Initialisation

    init(appServerClient: NetworkManager = NetworkManager()) {
        networkManager = appServerClient
    }
    
    // MARK: - Network Requests
    
    func downloadNews(completion: @escaping () -> Void) {
        
        networkManager.downloadNews() { [self] (articles) in
            
            self.articles = articles
            
            downloadImages{
                reloadCollectionView?()
            }
            reloadCollectionView?()
        }
    }
    
    func downloadImages(completion: @escaping () -> Void) {
        
        for article in articles {
            
            guard
                let thumbnailUrl = URL(string: article.thumbnailUrl)
            else {
                article.setImage(image: UIImage(named:"placeholder.jpg")!)
                continue
            }
            
            setThumbnailImage(url: thumbnailUrl) { (image) in
                article.setImage(image: image)
            }
        }
    }
    
    // MARK: - Public Methods 

    func setThumbnailImage(url: URL, completion: @escaping (UIImage) -> Void) {
        networkManager.downloadThumbnailImage(for: url) { (image) in
        completion(image)
        }
    }
}
