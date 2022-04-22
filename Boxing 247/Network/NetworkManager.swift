//
//  AppServerClient.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AppTrackingTransparency

class NetworkManager: NSObject {
    
    var urls  = [URL(string:"https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.boxinginsider.com%2Ffeed%2F"), URL(string:"https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.boxingnews24.com%2Ffeed%2F")]
//, URL(string:"https://api.rss2json.com/v1/api.json?rss_url=http%3A%2F%2Fwww.boxingnewsonline.net%2Ffeed%2F")
    
    func downloadNewsArticles(completion: @escaping (Error?) -> Void) {
        
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
                            successfulSave == self.urls.count ? completion(nil) : completion(CustomError(description: "There was a problem fetching all the latest news"))
                        }
                    }
                    
                case .failure(let error):
                    
                    print(error)
                    didntSave += 1
                    
                    let attemptedSaveCount = successfulSave + didntSave

                    if attemptedSaveCount == self.urls.count {
                        attemptedSaveCount == self.urls.count ? completion(error) : completion(CustomError(description: "There was a problem fetching all the latest news"))
                    }
                }
            }
        }
    }
    
    static func downloadBoxingData(completion: @escaping (Error?) -> Void) {
                
        #if DEBUG
        NetworkManager.loadMockData(){ error in
            completion(error)
        }
        #else
                
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let urlString = NSDictionary(contentsOfFile: path)?["boxingDataUrl"] as? String,
            let url = URL(string: urlString) /* AWS endpoint */
        else {
            NetworkManager.loadMockData(){ error in
                completion(error) }
            return
        }
        
        Alamofire.request(url).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                SaveUtility.saveBoxingData(withData: JSON(value)) { (error) in
                    #warning("error handling needed")
                    completion(nil)
                }
            case .failure(let error):
                completion(error)
            }
        }
        #endif
    }
    
    static func downloadThumbnailImage(for url: URL, completion: @escaping (UIImage?) -> ()) {
        
        Alamofire.request(url).responseData { (response) in
            
            if response.error == nil {
                if let data = response.data {
                   let image = UIImage(data: data)
                    completion(image!)
                }
            } else {
                print(response.result)
                completion(nil)
            }
        }
    }
    
    static func loadMockData(completion: @escaping (Error?) -> Void) {
        let data = FileExtractor.extractJsonFile(withName: "AllBoxingData", forClass: NetworkManager.self)
        guard let json =  try? JSON(data: data) else { fatalError() }
        SaveUtility.saveBoxingData(withData: json) { error in
            completion(error)
        }
    }
    
    static func requestPermission(completion: @escaping () -> Void) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
                
                completion()
            }
    }

}

