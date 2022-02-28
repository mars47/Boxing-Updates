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
    
    static func belts() -> [Belt]? {
        
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            let request = fetchRequest(entityName: "Belt", sortKey: "identifier")
            
            let belts = try context.fetch(request) as? [Belt]
            return belts?.sorted(by: { Int($0.identifier!)! < Int($1.identifier!)! } )
            
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func events() -> [Event]? {
        
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            let request = fetchRequest(entityName: "Event", sortKey: "identifier")
            
            let events = try context.fetch(request) as? [Event]
            return events?.sorted(by: { Int($0.identifier!)! < Int($1.identifier!)! } )
            
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func boxers() -> [Boxer]? {
        
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            let request = fetchRequest(entityName: "Boxer", sortKey: "identifier")
            
            let boxers = try context.fetch(request) as? [Boxer]
            return boxers?.sorted(by: { Int($0.identifier!)! < Int($1.identifier!)! } )
            
            
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func countrys() -> [Country]? {
        
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            let request = fetchRequest(entityName: "Country", sortKey: "identifier")
            
            let countrys = try context.fetch(request) as? [Country]
            return countrys?.sorted(by: { Int($0.identifier!)! < Int($1.identifier!)! } )
            
            
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func weightClasses() -> [WeightClass]? {
        
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            let request = fetchRequest(entityName: "WeightClass", sortKey: "lb")
            
           return try context.fetch(request) as? [WeightClass]
            
        } catch {
            print("Couldn't fetch news: \(error.localizedDescription)")
        }
        return nil
    }
    
    static func organisations() -> [Organisation]? {
        
        
        let context = CoreDataManager.shared.container.viewContext
        do {
            let request = fetchRequest(entityName: "Organisation", sortKey: "identifier")
            
            let organisations = try context.fetch(request) as? [Organisation]
            return organisations?.sorted(by: { Int($0.identifier!)! < Int($1.identifier!)! } )
            
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
        
    static func fetchRequest(entityName: String, sortKey: String, predicate: NSPredicate? = nil) -> NSFetchRequest<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicate
        return request
    }
}
