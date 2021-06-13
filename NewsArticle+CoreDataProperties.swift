//
//  NewsArticle+CoreDataProperties.swift
//  Boxing 247
//
//  Created by Omar on 08/06/2021.
//  Copyright © 2021 Omar. All rights reserved.
//
//

import Foundation
import CoreData


extension NewsArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsArticle> {
        return NSFetchRequest<NewsArticle>(entityName: "NewsArticle")
    }

    @NSManaged public var title: String?
    @NSManaged public var pubDate: Date?
    @NSManaged public var link: String?
    @NSManaged public var guid: String?
    @NSManaged public var author: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var thumbnail: Data?
    @NSManaged public var content: String?
    @NSManaged public var descriptionInfo: String?
    @NSManaged public var timeAgo: String?
    @NSManaged public var isBookmarked: Bool

}

extension NewsArticle : Identifiable {

}
