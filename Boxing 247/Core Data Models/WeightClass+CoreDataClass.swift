//
//  WeightClass+CoreDataClass.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(WeightClass)
public class WeightClass: NSManagedObject, Updatable {
        
    static var dataIdentifier: String = "id"
    static var objectIdentifier: String = "identifier"
    
    var beltSet : Set<Belt> {
        belts as? Set<Belt> ?? Set<Belt>()
    }
    
    var boxerSet : Set<Boxer> {
        boxers as? Set<Boxer> ?? Set<Boxer>()
    }
    
    var identifierInt : Int {
        Int(identifier!)!
    }
        
    enum Weight: Int {
        
        case heavyweight = 19
        case cruiserweight = 18
        case lightcruiserweight = 17
        case supermiddleweight = 16
        case middleweight = 15
        case superwelterweight = 21
        case welterweight = 14
        case superlightweight = 13
        case lightweight = 12
    }
    
    func update(with json: JSON) {
        
        identifier = "\(json["id"].intValue)"
        name = json["weight"].string
        lb = NSNumber(value: json["lb"].intValue)
    }
    
    func setId(id: String) {
        identifier = id
    }
}
