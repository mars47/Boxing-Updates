//
//  BeltTests.swift
//  Boxing 247Tests
//
//  Created by Omar on 16/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//

import XCTest
import CoreData
import SwiftyJSON
@testable import Boxing_247

class BeltTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        CoreDataManager.deInit()
    }
    
    func testddff() throws {
        
    }

    func testExample() throws {
        let data = dataFromFile("boxingData")
        
        if let json = try? JSON(data: data) {
            
        }
//        SaveUtility.saveBoxingData(withData: <#T##JSON#>) { isError in
//            <#code#>
//        }
            //Belt.managedObject(withJson: <#T##JSON#>, in: context )
        
    
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    
    func dataFromFile(_ fileName: String) -> Data {
        
        return FileExtractor.extractJsonFile(withName: fileName, forClass: type(of: self))
    }

}
