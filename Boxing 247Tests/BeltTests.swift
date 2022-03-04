//
//  Boxing_247Tests.swift
//  Boxing 247Tests
//
//  Created by Omar  on 30/06/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Boxing_247

class BeltTests: XCTestCase {
    
    var belts: [Belt]!
    var belt: Belt!
    
    var boxer: Boxer!
    var boxer2: Boxer!
    var weightclass: WeightClass!
    var organisation: Organisation!
    
    override func setUp() {
        super.setUp()
        initialiseBeltAndRelatedObjects()
    }
    
    override func tearDown() {
        CoreDataManager.deInit()
        boxer = nil
        belts = nil
        belt = nil
        super.tearDown()
    }
    
    func test_relationshipsLinked() {
        /* Tests that relationships have been linked through update method */
        XCTAssertFalse(boxer.beltSet.isEmpty)
        
        XCTAssert(belt.identifier == boxer?.beltSet.first?.identifier)
        XCTAssert(belt.name == boxer?.beltSet.first?.name)
        
        XCTAssert(belt.weightClass?.name == "Heavyweight")
        XCTAssert(belt.organisation?.fullName == "World Boxing Organization")
        
        XCTAssertNotNil(weightclass.beltSet.first(where: {belt.identifier == $0.identifier}) )
        XCTAssertNotNil(organisation.beltSet.first(where: {belt.identifier == $0.identifier}) )
    }
    
    func test_beltCountisOne() {
        /* Testing all instances of 'Belt' in question are referencing the same 1 belt object  */
        XCTAssert(FetchUtility.belts()?.count == 1)
    }
    
    func test_update() {
        /* Tests belt data is processed */
        
        XCTAssert(belt.boxer?.identifier == "1")
        let sep_01_2021 = Date(timeIntervalSince1970: 1630454400)
        XCTAssert(belt.acquiredDate == sep_01_2021)
        XCTAssert(belt.boxer?.firstName == "Dillian " )
        XCTAssert(belt.boxer?.lastName == "Whyte" )
        
        let expectation = self.expectation(description: "A new champion ('Boxer') has acquired a belt. Data from server for this '(Belt)' has now been updated")
        CoreDataManager.performBackgroundTask { (context) in
            
            let updatedData = self.dataFromFile("updatedBeltData")
            guard let updatedJSON =  try? JSON(data: updatedData) else { XCTFail("json failed"); return }
            Belt.managedObject(withJson: updatedJSON, in: context)
            CoreDataManager.shared.save()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        belts = FetchUtility.belts()
        belt = belts.first
        
        /* Tests for absence of a duplicated belt, after updated belt data from server has been processed */
        XCTAssert(belts.count == 1)
        /* Tests belt data is successfully updated after ownership of belt is transfered */
        XCTAssert(belt.boxer?.identifier == "2")
        let aug_01_2022 = Date(timeIntervalSince1970: 1659312000)
        XCTAssert(belt.acquiredDate == aug_01_2022)
        XCTAssert(belt.boxer?.firstName == "Deontay" )
        XCTAssert(belt.boxer?.lastName == "Wilder" )
    }
}

private extension BeltTests {
    
    func dataFromFile(_ fileName: String) -> Data {
        
        return FileExtractor.extractJsonFile(withName: fileName, forClass: type(of: self))
    }
    
    func initialiseBeltAndRelatedObjects() {
        
        let expectation = self.expectation(description: "Saving JSON data")
        let beltdata = dataFromFile("beltData")
        let boxerdata = dataFromFile("boxer1Data")
        let boxer2data = dataFromFile("boxer2Data")
        let weightclassdata = dataFromFile("weightclassData")
        let orgdata = dataFromFile("orgData")
        guard let beltjson =  try? JSON(data: beltdata) else { XCTFail("json failed"); return }
        guard let boxerjson =  try? JSON(data: boxerdata) else { XCTFail("json failed"); return }
        guard let boxer2json =  try? JSON(data: boxer2data) else { XCTFail("json failed"); return }
        guard let weightclassjson =  try? JSON(data: weightclassdata) else { XCTFail("json failed"); return }
        guard let orgjson =  try? JSON(data: orgdata) else { XCTFail("json failed"); return }
        
        CoreDataManager.performBackgroundTask { (context) in
            
            Belt.managedObject(withJson: beltjson, in: context)
            
            Boxer.managedObject(withJson: boxerjson, in: context)
            Boxer.managedObject(withJson: boxer2json, in: context)
            WeightClass.managedObject(withJson: weightclassjson, in: context)
            Organisation.managedObject(withJson: orgjson, in: context)
            
            CoreDataManager.shared.save()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        belts = FetchUtility.belts()
        belt = belts?.first
        boxer = Boxer.fetchObject(withId: "1", in:  CoreDataManager.shared.container.viewContext)
        boxer2 = Boxer.fetchObject(withId: "2", in:  CoreDataManager.shared.container.viewContext)
        weightclass = WeightClass.fetchObject(withId: "19", in:  CoreDataManager.shared.container.viewContext)
        organisation = Organisation.fetchObject(withId: "10", in:  CoreDataManager.shared.container.viewContext)
    }
}
