//
//  Country+CoreDataProperties.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?
    @NSManaged public var isoCode: String?
    @NSManaged public var identifier: String?
    @NSManaged public var boxers: NSSet?
    @NSManaged public var events: NSSet?

}

// MARK: Generated accessors for boxers
extension Country {

    @objc(addBoxersObject:)
    @NSManaged public func addToBoxers(_ value: Boxer)

    @objc(removeBoxersObject:)
    @NSManaged public func removeFromBoxers(_ value: Boxer)

    @objc(addBoxers:)
    @NSManaged public func addToBoxers(_ values: NSSet)

    @objc(removeBoxers:)
    @NSManaged public func removeFromBoxers(_ values: NSSet)

}

// MARK: Generated accessors for events
extension Country {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}

extension Country : Identifiable {

}
