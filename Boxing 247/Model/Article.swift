//
//  Article.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
// https://regexr.com

import Foundation
import SwiftyJSON

struct Article {
    
    private (set) var title: String
    private (set) var pubDate: String
    private (set) var link: String
    private (set) var guid: String
    private (set) var author: String
    private (set) var thumbnail: String
    private (set) var description: String
    private (set) var content: String
    private (set) var timeAgo: String


    init(initialiseArticleWith json:JSON) {
        
        title = json["title"].string!.replacingOccurrences(of: "&amp;", with: "&", options: .regularExpression, range: nil)
        pubDate = json["pubDate"].string!
        link = json["link"].string!
        guid = json["guid"].string!
        author = json["author"].string!
        thumbnail = json["thumbnail"].string!
        
        description = json["description"].string!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        description = self.description.trimmingCharacters(in: .whitespacesAndNewlines);
        //print(" My String: '\(self.description)'")
        content = json["content"].string!.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        //content = self.content
        
        // --- convert pubDate to timeAgo string ----
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        guard let date = dateFormatter.date(from: pubDate) else {
            self.timeAgo = "n/a"; return } //according to date format
         timeAgo = date.timeAgoSinceDate(date)
    }
}
