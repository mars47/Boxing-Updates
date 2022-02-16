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
        var didntSave = 0
    
        for url in urls {
            
            Alamofire.request(url!).responseJSON { response in
                
                switch response.result {
                
                case .success(let value):
                    SaveUtility.saveNewsArticles(withData: JSON(value)) { (isSuccess) in
                        
                        if isSuccess {
                            successfulSave += 1
                        } else {
                            didntSave += 1
                        }
                        
                        let attemptedSaveCount = successfulSave + didntSave
                        
                        if attemptedSaveCount == self.urls.count {
                            successfulSave == self.urls.count ? completion(true) : completion(false)
                        }
                    }
                    
                case .failure(let error):
                    
                    print(error)
                    didntSave += 1
                    
                    let attemptedSaveCount = successfulSave + didntSave

                    if attemptedSaveCount == self.urls.count {
                        completion(false)
                    }
                }
            }
        }
    }
    
    func downloadBoxingData(completion: @escaping (Error?) -> Void) {
        
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let urlString = NSDictionary(contentsOfFile: path)?["boxingDataUrl"] as? String,
            let url = URL(string: urlString)
        else { return }
        
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                SaveUtility.saveNewsArticles(withData: JSON(value)) { (isSuccess) in
                    
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func downloadThumbnailImage(for url: URL, completion: @escaping (UIImage) -> ()) {
        
        Alamofire.request(url).responseData { (response) in
            
            if response.error == nil {
                if let data = response.data {
                   let image = UIImage(data: data)
                    completion(image!)
                }
            } else {
                print(response.result)
                let image = UIImage(named: "ring.jpg")!
                completion(image)
            }
        }
    }
    
}

