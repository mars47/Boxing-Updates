//
//  BeltTests.swift
//  Boxing 247Tests
//
//  Created by Omar on 16/02/2022.
//  Copyright © 2022 Omar. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Boxing_247

class SaveUtilityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        CoreDataManager.deInit()
    }
    
    func test_saveBoxingData() throws {
        
        let expectation = self.expectation(description: "Saving JSON data")
        let data = dataFromFile("boxingData")
        guard let json =  try? JSON(data: data) else { XCTFail("json failed"); return }
        
        SaveUtility.saveBoxingData(withData: json) { error in

            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        guard let belts = FetchUtility.belts() else { XCTFail("belts = nil"); return }
        /* Tests omission of belts from lower weightclasses */
        XCTAssert(belts.count == 36)
        let belt = belts.first
        /* Tests belt data processed correctly */
        XCTAssert(belt?.name == "WBO Heavyweight")
        XCTAssert(belt?.identifier == "1")
        let sep_01_2021 = Date(timeIntervalSince1970: 1630454400)
        XCTAssert(belt?.acquiredDate == sep_01_2021 )
        XCTAssertNotNil(belt?.organisation)
        XCTAssertNotNil(belt?.boxer)
        XCTAssertNotNil(belt?.weightClass)
        
        guard let boxers = FetchUtility.boxers() else { XCTFail("boxers = nil"); return }
        XCTAssert(boxers.count == 27)
        guard boxers.indices.contains(1) else { XCTFail("array out of bounds"); return }
        let boxer = boxers[1]
        XCTAssert(boxer.identifier == "1")
        XCTAssert(boxer.thumbnailUrl == "https://boxrec.com/media/images//5/5c/Dwhyte.jpg")
        XCTAssert(boxer.firstName == "Dillian ")
        XCTAssert(boxer.lastName == "Whyte")
        let apr_11_1988 = Date(timeIntervalSince1970: 576720000)
        XCTAssert(boxer.dateOfBirth == apr_11_1988)
        
        guard let organisations = FetchUtility.organisations() else { XCTFail("boxers = nil"); return }
        XCTAssert(organisations.count == 4)
        let organisation = organisations.first
        XCTAssert(organisation?.identifier == "10")
        XCTAssert(organisation?.fullName == "World Boxing Organization")
        XCTAssert(organisation?.shortName == "WBO")

        guard let weightClasses = FetchUtility.weightClasses() else { XCTFail("boxers = nil"); return }
        XCTAssert(weightClasses.count == 9)
        let weightClass = weightClasses.last
        XCTAssert(weightClass?.identifier == "12")
        XCTAssert(weightClass?.name == "Lightweight")
        XCTAssert(weightClass?.lb == 135)
        
        guard let countrys = FetchUtility.countrys() else { XCTFail("boxers = nil"); return }
        XCTAssert(countrys.count == 13)
        let country = countrys.first
        XCTAssert(country?.identifier == "1")
        XCTAssert(country?.name == "United Kingdom ")
        XCTAssert(country?.isoCode == "uk")
        
        /* any changes to how data is extracted:
         
         - in each NSManaged Object subclass
         - from root JSON dictionary used in SaveUtility.saveBoxingData
         
          ...will fail this test */
    }

    
    func dataFromFile(_ fileName: String) -> Data {
        
        return FileExtractor.extractJsonFile(withName: fileName, forClass: type(of: self))
    }

}
