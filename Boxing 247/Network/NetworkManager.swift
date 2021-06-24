//
//  AppServerClient.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    
    var urls  = [URL(string:"https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.boxinginsider.com%2Ffeed%2F"), URL(string:"https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.boxingnews24.com%2Ffeed%2F")]
//, URL(string:"https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Fwww.boxingnewsonline.net%2Ffeed%2F")
    func downloadNewsArticles(completion: @escaping (Bool) -> Void) {
        
        var successfulSave = 0
    
        for (index, url) in urls.enumerated() {
            let islastIteration = index == self.urls.endIndex - 1
            
            Alamofire.request(url!).responseJSON { response in
                
                switch response.result {
                
                case .success(let value):
                    
                    SaveUtility.saveNewsArticles(withData: JSON(value)) { (isSuccess) in
                        
                        if isSuccess { successfulSave += 1 }
                        if islastIteration {
                            successfulSave == self.urls.count ? completion(true) : completion(false)
                        }
                    }
                    
                case .failure(let error):
                    
                    print(error)
                    
                    if islastIteration {
                        completion(false)
                    }
                }
            }
        }
    }
    
    func downloadThumbnailImage(for url: URL, completion: @escaping (UIImage) -> ()) {
        
        Alamofire.request(url).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                   let image = UIImage(data: data)
                    completion(image!)
                }
            } else {
                let image = UIImage(named: "placeholder.jpg")!
                completion(image)
            }
        }
    
    }
    
//    func downloadNews(completion: @escaping ([Article]) -> ()) {
//        
//        articles.removeAll()
//        guard let newsfeedURL = URL(string: "https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Fwww.boxingnewsonline.net%2Ffeed%2F")
//            else { completion([Article]()); return }
//        var json : JSON?
//        
//        Alamofire.request(newsfeedURL).responseJSON { response in
//            
//            switch response.result {
//            case .success(let value):
//                json = JSON(value)
//
//                for dict in json!["items"].arrayValue {
//                    let article = Article(initWith: dict)
//                    self.articles.append(article)
//                }
//                completion(self.articles)
//            
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}

