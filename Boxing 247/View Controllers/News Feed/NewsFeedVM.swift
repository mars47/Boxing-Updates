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
    var newsArticles: [NewsArticle] = []
    let networkManager : NetworkManager
        
    // MARK: - Initialisation

    init(appServerClient: NetworkManager = NetworkManager()) {
        networkManager = appServerClient
    }
    
    // MARK: - Public Methods
    
    func downloadNews(for tab: NewsFeedVC.Segment, completion: (() -> Void)?) {
        
        #warning("Error handling needed")
        networkManager.downloadNewsArticles { [self] _ in
            completion?()
            fetchNewsArticles(for: tab)
        }
    }
    
    func fetchNewsArticles(for tab: NewsFeedVC.Segment) {
        
        guard let newsArticles = tab == .bookmarked ?
            FetchUtility.bookmarkedNews() :
            FetchUtility.news(fetch: .new)
        else {
            print("fetch failure")
            return
        }

        self.newsArticles = newsArticles
                
        downloadImages{
            self.reloadCollectionView?()
        }
        
        reloadCollectionView?()
    }
    
    func downloadImages(completion: @escaping () -> Void) {
        
        for (index, article) in newsArticles.enumerated() {
            
            guard
                let url = article.thumbnailUrl,
                let thumbnailUrl = URL(string: url)
            else {
                article.setImage(image: UIImage(named:"placeholder.jpg")!)
                
                if index == newsArticles.endIndex - 1 {
                    completion()
                }
                continue
            }
            
            setThumbnailImage(url: thumbnailUrl) { [self] (image) in
                
                article.setImage(image: image)
                
                if index == newsArticles.endIndex - 1 {
                    completion()
                }
            }
        }
    }
    
    // MARK: - Private Methods

    private func setThumbnailImage(url: URL, completion: @escaping (UIImage) -> Void) {
        
        networkManager.downloadThumbnailImage(for: url) { (image) in
            completion(image)
        }
    }  
}
