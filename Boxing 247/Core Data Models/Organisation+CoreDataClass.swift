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
    
    var beltSet : Set<Belt> {
        belts as? Set<Belt> ?? Set<Belt>()
    }
    
    var identifierInt : Int {
        Int(identifier!)!
    }
        
    enum Id: Int {
        
        case wbo = 10
        case wba = 12
        case wbc = 11
        case ibf = 13
    }
        
    func update(with json: JSON) {
        
        identifier = "\(json["id"].intValue)"
        fullName = json["fullName"].string
        shortName = json["shortName"].string
    }
    
    func setId(id: String) {
        identifier = id
    }

}
