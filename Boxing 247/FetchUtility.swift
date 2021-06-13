//
//  FetchUtility .swift
//  Boxing 247
//
//  Created by Omar on 11/06/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import Foundation
import CoreData

class FetchUtility {
    
    enum NewsType {
        case old
        case new
    }
    
    static func news(fetch newsType: NewsType) -> [NewsArticle]? {
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            return try (context.fetch(newsRequest(for: newsType)) as? [NewsArticle])
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
}

private extension FetchUtility {
    
    static func newsRequest(for newsType: NewsType) -> NSFetchRequest<NSFetchRequestResult> {
        
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        
        let predicate1 = newsType == .new ?
            NSPredicate(format: "pubDate >= %@", threeDaysAgo as NSDate) :
            NSPredicate(format: "pubDate < %@", threeDaysAgo as NSDate)
        
        let predicate2 = newsType == .new ?
            NSPredicate(format: "isBookmarked = %d", true) :
            NSPredicate(format: "isBookmarked = %d", false)
        
        let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1,predicate2])
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsArticle")
        let sortDescriptor = NSSortDescriptor(key: "pubDate", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicateCompound
        return request
    }
}
