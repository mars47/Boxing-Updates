//
//  NewsArticle+CoreDataClass.swift
//  Boxing 247
//
//  Created by Omar on 08/06/2021.
//  Copyright © 2021 Omar. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(NewsArticle)
public class NewsArticle: NSManagedObject, Updatable {
            
    static var dataIdentifier: String = "guid"
    static var objectIdentifier: String = "guid"

    func update(with dictionary: JSON) {
        
        guid = dictionary["guid"].string // unique identifier
        title = dictionary["title"].string?.replacingOccurrences(of: "&amp;", with: "&", options: .regularExpression, range: nil)
        setPubdate(dictionary["pubDate"].string)
        link = dictionary["link"].string
        author = dictionary["author"].string
        thumbnailUrl = thumbnailUrl(from: dictionary)
        descriptionInfo = dictionary["description"].string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        descriptionInfo = self.description.trimmingCharacters(in: .whitespacesAndNewlines);
        content = dictionary["content"].string?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).replacingOccurrences(of: "&amp;", with: "&", options: .regularExpression, range: nil)
    }
    
    func thumbnailUrl(from dictionary: JSON) -> String? {
        
        let isUrlEmpty = (dictionary["thumbnail"].string == nil) || (dictionary["thumbnail"].string?.isEmpty ?? false)
        
        return isUrlEmpty ? dictionary["enclosure"]["link"].string : dictionary["thumbnail"].string
    }
    
    func setPubdate(_ pubDateString: String?) {

        guard let pubDateString = pubDateString else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        pubDate = dateFormatter.date(from: pubDateString)
    }
    
    func setImage(image: UIImage) {
        
        if image.size == CGSize(width: 1.0, height: 1.0) { return }
        thumbnail = image.pngData() ?? image.jpegData(compressionQuality: 1)
    }
}
