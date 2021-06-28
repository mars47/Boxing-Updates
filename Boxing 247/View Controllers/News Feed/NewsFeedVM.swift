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
    var scrollCollectionView : ( () -> Void)?

    let url = URL(string: "https://bit.ly/2tZmM0E")

    var datasource: [NewsArticle] = []
    var newsArticles: [NewsArticle] = []
    var bookmarkedNewsArticles: [NewsArticle] = []
    
    var collectionViewScrollOffset = 0
    var snapshotForSegmentLatest : (Int, IndexPath?)?
    
    let networkManager : NetworkManager
    var allItemsFetched : Bool {
        return datasource.count == newsArticles.count
    }

    // MARK: - Initialisation

    init(appServerClient: NetworkManager = NetworkManager()) {
        networkManager = appServerClient
    }
    
    // MARK: - Public Methods
    
    func downloadNews(for tab: NewsFeedVC.Segment, completion: (() -> Void)?) {
        
        #warning("Error handling needed") // "there was a problem fetching the latest news" 
        networkManager.downloadNewsArticles { [self] _ in
            
            newsArticles.removeAll()
            bookmarkedNewsArticles.removeAll()
            
            newsArticles = FetchUtility.news(fetch: .new)!
            bookmarkedNewsArticles = FetchUtility.bookmarkedNews()!

            downloadImages(for: newsArticles){ [self] in
                
                SaveUtility.saveChanges()
                reloadCollectionView?()
            }
            
            updateDatasource(for: tab, itemsDisplayedCount: 0)
            reloadCollectionView?()
            completion?()
        }
    }
    
    func updateDatasource(for segment: NewsFeedVC.Segment, itemsDisplayedCount: Int ) {
       
        let datasourceAllItemsCount = (segment == .bookmarked) ? bookmarkedNewsArticles.count: newsArticles.count
        
        let newItemsToDisplayCount =
            (datasourceAllItemsCount - itemsDisplayedCount) >= fetchLimit ? fetchLimit :
            (datasourceAllItemsCount - itemsDisplayedCount)
        
        collectionViewScrollOffset = newItemsToDisplayCount

        switch segment {
        
        case .latest:
            datasource =
                Array(newsArticles[0..<itemsDisplayedCount + newItemsToDisplayCount])

        case .bookmarked:
            datasource =
                Array(bookmarkedNewsArticles[0..<itemsDisplayedCount + newItemsToDisplayCount])
        }
                
    }
    
    func updateDatasourceBookmarkRemoved() {
        datasource = FetchUtility.bookmarkedNews()!
        SaveUtility.saveChanges()
    }
    
    func switchDatasource(for selectedSegment: NewsFeedVC.Segment, indexPath: IndexPath?) {
        
        if selectedSegment == .bookmarked {
            bookmarkedNewsArticles = FetchUtility.bookmarkedNews()!
            snapshotForSegmentLatest = (datasource.count, indexPath)
        }
        
        switch selectedSegment {
        
        case .latest:
            datasource =
                Array(newsArticles[0..<snapshotForSegmentLatest!.0])
        case .bookmarked:
            datasource =
                bookmarkedNewsArticles
        }
        
    }
    
    // MARK: - Private Methods

    private func downloadImages(for newsArticles: [NewsArticle], completion: @escaping () -> Void) {
        
        for (index, article) in newsArticles.enumerated() {
            
            if article.thumbnail != nil { continue }
            
            guard
                let url = article.thumbnailUrl,
                let thumbnailUrl = URL(string: url)
            else {
                article.setImage(image: UIImage(named:"ring.jpg")!)
                
                if index == newsArticles.endIndex - 1 {
                    completion()
                }
                continue
            }
            
            downloadThumbnailImage(url: thumbnailUrl) { (image) in
                
                article.setImage(image: image)
                
                if index == newsArticles.endIndex - 1 {
                    completion()
                }
            }
        }
    }
    
    private func downloadThumbnailImage(url: URL, completion: @escaping (UIImage) -> Void) {
        
        networkManager.downloadThumbnailImage(for: url) { (image) in
            completion(image)
        }
    }  
}
