//
//  Boxer+CoreDataClass.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Boxer)
public class Boxer: NSManagedObject, Updatable {
        
    static var dataIdentifier: String = "id"
    static var objectIdentifier: String = "identifier"
    
    func update(with json: JSON) {
        
        identifier = "\(json["id"].intValue)"
        firstName = json["firstName"].string
        lastName = json["lastName"].string
        if let date = json["dateOfBirth"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
            dateOfBirth = dateFormatter.date(from:date)
        }
        thumbnailUrl = json["thumbnailUrl"].string
        
        if let countryId = json["countryId"].int {
            country = Country.fetchOrCreateObject(withId: "\(countryId)", in: managedObjectContext!)
            country?.setId(id: "\(countryId)")
        }
        if let weightClassId = json["weightClassId"].int {
            weightClass = WeightClass.fetchOrCreateObject(withId: "\(weightClassId)", in: managedObjectContext!)
            weightClass?.setId(id: "\(weightClassId)")
        }
    }
    
    func setId(id: String) {
        identifier = id
    }
    
}
