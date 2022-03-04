//
//  Boxing_247Tests.swift
//  Boxing 247Tests
//
//  Created by Omar on 02/03/2022.
//  Copyright © 2022 Omar. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Boxing_247

class Boxing_247Tests: XCTestCase {
    
    let mar_02_2022 = Date(timeIntervalSince1970: 1646179200)
    let feb_25_2022 = Date(timeIntervalSince1970: 1645747200)
    let appDelegate = AppDelegate()

    override func setUp() {
        super.setUp()
    }

    override func tearDownWithError() throws {
        CoreDataManager.deInit()
    }

    func test_deleteOldNewsArticlesAfter5days() {
        
        XCTAssert(FetchUtility.news(fetch: .all)?.count == 0)
        initialiseMockNewsArticles()
        XCTAssert(FetchUtility.news(fetch: .all)?.count == 10)

        /* Articles are from: Feb 21th - March 2nd 2022.
         Articles on Feb 25th and before (old articles) should be deleted */
        appDelegate.deleteOldNewsArticlesAfter5days(pointInTime: mar_02_2022)
        
        XCTAssert(FetchUtility.news(fetch: .latest, from: mar_02_2022)?.count == 5)
        
        guard let news = FetchUtility.news(fetch: .latest, from: mar_02_2022) else {
            XCTFail("guard failed"); return
        }

        for article in news {
            XCTAssertNotNil(article.pubDate)
            XCTAssert(article.pubDate! > feb_25_2022)
            /*   21 22 23 24 25 deleted
                 26 27 28 01 02 kept   */
        }
    }

    func dataFromFile(_ fileName: String) -> Data {
        
        return FileExtractor.extractJsonFile(withName: fileName, forClass: type(of: self))
    }
}

private extension Boxing_247Tests {
    
    func initialiseMockNewsArticles() {
        
        let expectation = self.expectation(description: "Saving JSON data")
        
        CoreDataManager.performBackgroundTask { (context) in
           
            let data = self.dataFromFile("newsArticlesData")
            guard let json =  try? JSON(data: data) else { XCTFail("json failed"); return }

            guard
                let dictionary = json.dictionary,
                let newsArticles = dictionary["items"]?.array
            else { XCTFail("json failed"); return }
            
            for article in newsArticles {
                NewsArticle.managedObject(withJson: article, in: context)
            }
            
            CoreDataManager.shared.save()
            expectation.fulfill()
        }
    
        waitForExpectations(timeout: 500, handler: nil)
    }
}
