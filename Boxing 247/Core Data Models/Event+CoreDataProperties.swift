//
//  Event+CoreDataProperties.swift
//  Boxing 247
//
//  Created by Omar on 26/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var date: Date?
    @NSManaged public var identifier: String?
    @NSManaged public var title: String?
    @NSManaged public var venue: String?
    @NSManaged public var boxers: Boxer?
    @NSManaged public var country: Country?
    @NSManaged public var mainEvent: Event?
    @NSManaged public var undercards: NSSet?
    @NSManaged public var weightClass: WeightClass?

}

// MARK: Generated accessors for undercards
extension Event {

    @objc(addUndercardsObject:)
    @NSManaged public func addToUndercards(_ value: Event)

    @objc(removeUndercardsObject:)
    @NSManaged public func removeFromUndercards(_ value: Event)

    @objc(addUndercards:)
    @NSManaged public func addToUndercards(_ values: NSSet)

    @objc(removeUndercards:)
    @NSManaged public func removeFromUndercards(_ values: NSSet)

}

extension Event : Identifiable {

}
