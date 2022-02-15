//
//  Belt+CoreDataProperties.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData


extension Belt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Belt> {
        return NSFetchRequest<Belt>(entityName: "Belt")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var name: String?
    @NSManaged public var acquiredDate: String?
    @NSManaged public var boxer: Boxer?
    @NSManaged public var organisation: Organisation?
    @NSManaged public var weightClass: WeightClass?

}

extension Belt : Identifiable {

}
