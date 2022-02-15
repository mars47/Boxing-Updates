//
//  Event+CoreDataClass.swift
//  Boxing 247
//
//  Created by Omar on 14/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(Event)
public class Event: NSManagedObject, Updatable {
    
    static var dataIdentifier: String = ""
    static var objectIdentifier: String = ""
    
    func update(with json: JSON) {
        
    }

}
