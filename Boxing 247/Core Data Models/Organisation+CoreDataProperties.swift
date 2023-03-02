//
//  Organisation+CoreDataProperties.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData


extension Organisation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Organisation> {
        return NSFetchRequest<Organisation>(entityName: "Organisation")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var shortName: String?
    @NSManaged public var fullName: String?
    @NSManaged public var belts: NSSet?

}

// MARK: Generated accessors for belts
extension Organisation {

    @objc(addBeltsObject:)
    @NSManaged public func addToBelts(_ value: Belt)

    @objc(removeBeltsObject:)
    @NSManaged public func removeFromBelts(_ value: Belt)

    @objc(addBelts:)
    @NSManaged public func addToBelts(_ values: NSSet)

    @objc(removeBelts:)
    @NSManaged public func removeFromBelts(_ values: NSSet)

}

extension Organisation : Identifiable {

}
