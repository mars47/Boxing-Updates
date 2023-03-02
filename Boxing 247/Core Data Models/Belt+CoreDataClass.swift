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
        
        if let date = json["acquiredDate"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
            acquiredDate = dateFormatter.date(from:date)
        }
        
        if let boxerId = json["boxerId"].int {
            boxer = Boxer.fetchOrCreateObject(withId: "\(boxerId)", in: managedObjectContext!)
            boxer?.setId(id: "\(boxerId)")
        }
        if let weightClassId = json["weightClassId"].int {
            weightClass = WeightClass.fetchOrCreateObject(withId: "\(weightClassId)", in: managedObjectContext!)
            weightClass?.setId(id: "\(weightClassId)")
        }
        if let organisationId = json["organizationId"].int {
            organisation = Organisation.fetchOrCreateObject(withId: "\(organisationId)", in: managedObjectContext!)
            organisation?.setId(id: "\(organisationId)")
        }
    }
    
    func setId(id: String) {
        identifier = id
    }
}
