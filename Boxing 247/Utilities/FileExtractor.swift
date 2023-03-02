//
//  FileExtractor.swift
//  Boxing 247
//
//  Created by Omar on 15/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//

import Foundation

class FileExtractor {
    
    static func extractJsonFile(withName name: String, forClass bundleClass: AnyClass) -> Data {
        
        do {
            guard let url = Bundle(for: bundleClass).url(forResource: name, withExtension: "json") else {
                
                fatalError("json file \(name) not found")
            }
            
            return try Data(contentsOf: url)
            
        } catch {

            fatalError(error.localizedDescription)
        }
    }
}
