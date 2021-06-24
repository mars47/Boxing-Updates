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
            
            let request = newsRequest(for: newsType)
            
            return try context.fetch(request) as? [NewsArticle]
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func bookmarkedNews() -> [NewsArticle]? {
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            let request = fetchRequest(entityName: "NewsArticle", sortKey: "pubDate", predicate: NSPredicate(format: "isBookmarked = %d", true))
            
            return try context.fetch(request) as? [NewsArticle]
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
}

private extension FetchUtility {
    
    static func newsRequest(for newsType: NewsType) -> NSFetchRequest<NSFetchRequestResult> {
        
        let fiveDaysAgo = Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        
        let predicate1 = newsType == .new ?
            NSPredicate(format: "pubDate >= %@", fiveDaysAgo as NSDate) :
            NSPredicate(format: "pubDate < %@", fiveDaysAgo as NSDate)
        
        let predicate2 = NSPredicate(format: "isBookmarked = %d", false)
        
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
        
        return fetchRequest(entityName: "NewsArticle", sortKey: "pubDate", predicate: newsType == .new ? predicate1 : predicateCompound)
    }
        
    static func fetchRequest(entityName: String, sortKey: String, predicate: NSPredicate) -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicate
        return request
    }
}
