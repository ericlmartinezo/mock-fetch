//
//  mock_fetchTests.swift
//  mock-fetchTests
//
//  Created by Eric Martinez on 9/25/19.
//  Copyright © 2019 emobile. All rights reserved.
//
import Foundation
import XCTest
import SwiftyJSON

class mock_fetchTests: XCTestCase {
//     This test sample is for using mock data 
    
    var testData: Data!

    override func setUp() {
        
        super.setUp()
        

        if let file = Bundle(for: mock_fetchTests.self).path(forResource: "TestCompanyMock", ofType: "json") {
            self.testData = try? Data(contentsOf: URL(fileURLWithPath: file))
        } else {
            XCTFail("Can't find the test JSON file")
        }
    }

    func testSample() {
        
        guard let json = try? JSON(data: self.testData) else {
                XCTFail("Unable to parse testData")
                return
            }

            let tweets = json
            let tweets_array = json.array
            let tweets_1 = json[1]
            _ = tweets_1[1]
            let tweets_1_user_name = tweets_1["address"]["street"]
            let tweets_1_user_name_string = tweets_1["address"]["street"].string
            XCTAssertNotEqual(tweets.type, Type.null)
            XCTAssert(tweets_array != nil)
            XCTAssertNotEqual(tweets_1.type, Type.null)
            XCTAssertEqual(tweets_1_user_name, JSON("Victor Plains"))
            XCTAssertEqual(tweets_1_user_name_string!, "Victor Plains")
            
            let tweets_0 = json[0]

            let tweets_0_company_name = tweets_0["company"]["name"]
            let tweets_0_company_name_string = tweets_0["company"]["name"].string
            XCTAssertEqual(tweets_0_company_name, JSON("Romaguera-Crona"))
            XCTAssertEqual(tweets_0_company_name_string!, "Romaguera-Crona")
            
            let tweets_0_username = tweets_0["username"]
            let tweets_0_username_string = tweets_0["username"].string
            XCTAssertEqual(tweets_0_username, JSON("Bret"))
            XCTAssertEqual(tweets_0_username_string!, "Bret")
        }
}
