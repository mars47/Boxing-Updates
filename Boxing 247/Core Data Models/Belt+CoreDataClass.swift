//
//  Belt+CoreDataClass.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Belt)
public class Belt: NSManagedObject, Updatable  {
    
    static var dataIdentifier: String = "id"
    static var objectIdentifier: String = "identifier"
    
    func update(with json: JSON) {
        
        identifier = "\(json["id"].intValue)"
        name = json["name"].string
        acquiredDate = json["acquiredDate"].string
        
        if let boxerId = json["boxerId"].int {
            self.boxer = Boxer.object(withId: "\(boxerId)", in: managedObjectContext!)
        }
        if let weightClassId = json["weightClassId"].int {
            self.weightClass = WeightClass.object(withId: "\(weightClassId)", in: managedObjectContext!)
        }
        if let organisationId = json["organizationId"].int {
            self.organisation = Organisation.object(withId: "\(organisationId)", in: managedObjectContext!)
        }
    }
}
