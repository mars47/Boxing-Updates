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
    var presentNoInternetView : ( () -> Void)?
    var hideLoadingView : ( () -> Void)?


    let url = URL(string: "https://bit.ly/2tZmM0E")

    var datasource: [NewsArticle] = []
    var newsArticles: [NewsArticle] = []
    var bookmarkedNewsArticles: [NewsArticle] = []
    
    var collectionViewScrollOffset = 0
    var snapshotForSegmentLatest : (Int, IndexPath?)?
    private(set) var latestSegementContentHeight : CGFloat = 0
    
    let networkManager : NetworkManager
    var isAllItemsFetched : Bool {
        return datasource.count == newsArticles.count
    }
    
    var itemsScolledCount = 0
    var isDownloadingData = false 
    var isInternetConnectionEnabled : Bool {
        ConnectionManager.shared.hasConnectivity()
    }

    // MARK: - Initialisation

    init(appServerClient: NetworkManager = NetworkManager()) {
        networkManager = appServerClient
    }
    
    // MARK: - Public Methods
    
    func downloadNews(for segment: NewsFeedVC.Segment, completion: (() -> Void)? ) {
        
        #warning("Error handling needed") // "there was a problem fetching the latest news" 
        isDownloadingData = true
        networkManager.downloadNewsArticles { [self] _ in
            
            newsArticles.removeAll()
            bookmarkedNewsArticles.removeAll()
            
            newsArticles = FetchUtility.news(fetch: .latest) ?? []
            bookmarkedNewsArticles = FetchUtility.bookmarkedNews() ?? []

            downloadImages(for: newsArticles){ [self] in
                
                SaveUtility.saveChanges()
                reloadCollectionView?()
            }
            
            updateDatasource(for: segment, itemsDisplayedCount: 0)
            isDownloadingData = false
            hideLoadingView?()
            reloadCollectionView?()
            completion?()
        }
    }
    
    func updateDatasource(for segment: NewsFeedVC.Segment, itemsDisplayedCount: Int) {
       
        let datasourceAllItemsCount = (segment == .bookmarked) ? bookmarkedNewsArticles.count: newsArticles.count
        
        let newItemsToDisplayCount =
            (datasourceAllItemsCount - itemsDisplayedCount) >= fetchLimit ? fetchLimit :
            (datasourceAllItemsCount - itemsDisplayedCount)
        
        collectionViewScrollOffset = newItemsToDisplayCount

        switch segment {
        
        case .latestNews:
            datasource =
                Array(newsArticles[0..<itemsDisplayedCount + newItemsToDisplayCount])

        case .bookmarked:
            datasource =
                Array(bookmarkedNewsArticles[0..<itemsDisplayedCount + newItemsToDisplayCount])
        }
                
    }
    
    func updateDatasourceBookmarkRemoved() {
        #warning("Needs refactoring")
        datasource = FetchUtility.bookmarkedNews()!
        bookmarkedNewsArticles = datasource
        SaveUtility.saveChanges()
    }
    
    func switchDatasource(for selectedSegment: NewsFeedVC.Segment, indexPath: IndexPath?) {
        
        if selectedSegment == .bookmarked {
            bookmarkedNewsArticles = FetchUtility.bookmarkedNews()!
            snapshotForSegmentLatest = (datasource.count, indexPath)
        }
        
        switch selectedSegment {
        
        case .latestNews:
            datasource =
                Array(newsArticles[0..<snapshotForSegmentLatest!.0])
        case .bookmarked:
            datasource =
                bookmarkedNewsArticles
        }
    }
    
    func handleItemsScrolled() {
        
       // if !isInternetConnectionEnabled {
            presentNoInternetView?()
       // }
        
        itemsScolledCount = 0 
    }
    
    func getEmptyDatasetText(for selectedSegment: NewsFeedVC.Segment) -> (String, String) {
        
        switch selectedSegment {
        
        case .bookmarked:
            return ("You have no saved items", "book.circle.fill")
        
        case .latestNews:
            return ("Unfortunately there has been a problem. Unable to find any news", "exclamationmark.bubble.fill")
        }
    }
    
    func storeContentsSizeHeight(_ contentsSizeHeight: CGFloat, selectedSegment: NewsFeedVC.Segment) {
        
        if selectedSegment == .bookmarked {
            self.latestSegementContentHeight = contentsSizeHeight
        }
    }
    
    // MARK: - Private Methods

    private func downloadImages(for newsArticles: [NewsArticle], completion: @escaping () -> Void) {
        
        var setImageCount = 0
        
        for article in newsArticles {
            
            if article.thumbnail != nil {
                
                setImageCount += 1
                continue
            }
            
            guard
                let url = article.thumbnailUrl,
                let thumbnailUrl = URL(string: url)
            else {
                article.setImage(image: UIImage(named:"ring.jpg")!)
                setImageCount += 1
                if setImageCount == newsArticles.count {
                    completion()
                }
                continue
            }
            
            downloadThumbnailImage(url: thumbnailUrl) { (image) in
                
                article.setImage(image: image)
                setImageCount += 1
                
                if setImageCount == newsArticles.count {
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
