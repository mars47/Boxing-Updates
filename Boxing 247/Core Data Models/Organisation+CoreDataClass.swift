//
//  Organisation+CoreDataClass.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Organisation)
public class Organisation: NSManagedObject, Updatable {
        
    static var dataIdentifier: String = "id"
    static var objectIdentifier: String = "identifier"
    
    func update(with json: JSON) {
        
        identifier = "\(json["id"].intValue)"
        fullName = json["fullName"].string
        shortName = json["shortName"].string
    }
    
    func setId(id: String) {
        identifier = id
    }

}
