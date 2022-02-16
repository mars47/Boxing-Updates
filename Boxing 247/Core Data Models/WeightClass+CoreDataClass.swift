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

    static var dataIdentifier: String = ""
    static var objectIdentifier: String = ""
    
    func update(with json: JSON) {
        
        guard Weight(rawValue: Int(identifier!)! ) != nil else {
            return
        }
        
        
        
    }
}
