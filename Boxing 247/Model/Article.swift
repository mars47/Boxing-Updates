//
//  Article.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
// https://regexr.com

import Foundation
import SwiftyJSON

class Article {
    
    private (set) var title: String
    private (set) var pubDate: String
    private (set) var link: String
    private (set) var guid: String
    private (set) var author: String
    private (set) var thumbnailUrl: String
    private (set) var description: String
    private (set) var content: String
    private (set) var timeAgo: String
    private (set) var image: UIImage?
    
    let dateFormatter = DateFormatter()

    init(initWith dictionary: JSON) {
        
        guid = dictionary["guid"].string! // unique identifier
        title = dictionary["title"].string!.replacingOccurrences(of: "&amp;", with: "&", options: .regularExpression, range: nil)
        pubDate = dictionary["pubDate"].string!
        link = dictionary["link"].string!
        author = dictionary["author"].string!
        thumbnailUrl = dictionary["thumbnail"].string!
        
        description = dictionary["description"].string!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        description = self.description.trimmingCharacters(in: .whitespacesAndNewlines);
        content = dictionary["content"].string!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        //content = self.content
        
        // --- convert pubDate to timeAgo string ----
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        guard let date = dateFormatter.date(from: pubDate) else {
            self.timeAgo = "n/a"; return } //according to date format
         timeAgo = date.timeAgoSinceDate(date)
    }
    
    func setImage(image: UIImage) {
        self.image = image
    }
}
