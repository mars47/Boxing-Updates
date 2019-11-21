//
//  NewsFeedCellVM.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NewsFeedCellVM: NSObject {
    
    let article: Article
    let appServerClient: AppServerClient
    var image: UIImage!
    
    init(article: Article, appServerClient: AppServerClient = AppServerClient()) {
        
        self.article = article
        self.appServerClient = appServerClient
        super.init()
        guard let thumbnailUrl = URL(string: article.thumbnailUrl)
            else {
                self.image = UIImage(named:"placeholder.jpg")!
                return
        }
        setThumbnailImage(url: thumbnailUrl) // asynchronous network request
    }
    
    func setThumbnailImage(url: URL) {
        appServerClient.downloadThumbnailImage(for: url) { (result) in
        self.image = result
        }
    }
}
