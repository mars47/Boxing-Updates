//
//  Boxer+CoreDataProperties.swift
//  Boxing 247
//
//  Created by Omar on 26/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData


extension Boxer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Boxer> {
        return NSFetchRequest<Boxer>(entityName: "Boxer")
    }

    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var firstName: String?
    @NSManaged public var identifier: String?
    @NSManaged public var lastName: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var belts: NSSet?
    @NSManaged public var country: Country?
    @NSManaged public var events: NSSet?
    @NSManaged public var weightClass: WeightClass?

}

// MARK: Generated accessors for belts
extension Boxer {

    @objc(addBeltsObject:)
    @NSManaged public func addToBelts(_ value: Belt)

    @objc(removeBeltsObject:)
    @NSManaged public func removeFromBelts(_ value: Belt)

    @objc(addBelts:)
    @NSManaged public func addToBelts(_ values: NSSet)

    @objc(removeBelts:)
    @NSManaged public func removeFromBelts(_ values: NSSet)

}

// MARK: Generated accessors for events
extension Boxer {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}

extension Boxer : Identifiable {

}
