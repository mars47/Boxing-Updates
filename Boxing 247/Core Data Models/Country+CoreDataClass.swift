//
//  Country+CoreDataClass.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Country)
public class Country: NSManagedObject, Updatable  {
    
    static var dataIdentifier: String = "id"
    static var objectIdentifier: String = "identifier"
    
    var boxerSet : Set<Boxer> {
        boxers as? Set<Boxer> ?? Set<Boxer>()
    }
    
    func update(with json: JSON) {
        
        identifier = "\(json["id"].intValue)"
        name = json["name"].string
        isoCode = json["isoCode"].string
    }
    
    func setId(id: String) {
        identifier = id
    }
}
