//
//  Article.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

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


    init(initialiseArticleWith json:JSON) {
        
        self.title = json["title"].string!
        self.pubDate = json["pubDate"].string!
        self.link = json["link"].string!
        self.guid = json["guid"].string!
        self.author = json["author"].string!
        self.thumbnail = json["thumbnail"].string!
        
        self.description = json["description"].string!
        self.description = self.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.description = self.description.trimmingCharacters(in: .whitespacesAndNewlines);
        //print(" My String: '\(self.description)'")
        self.content = json["content"].string!
        self.content = self.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
