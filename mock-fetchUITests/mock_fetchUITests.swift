//
//  mock_fetchUITests.swift
//  mock-fetchUITests
//
//  Created by Eric Martinez on 10/8/19.
//  Copyright © 2019 emobile. All rights reserved.
//
import Foundation
import XCTest

class mock_fetchUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
        if #available(iOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testGitUserDataXc() {
        guard let gitUrl = URL(string: "https://api.github.com/users/ericlmartinezo") else { return }
        let promise = expectation(description: "Simple Request")
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                if let result = json as? NSDictionary {
                    XCTAssertTrue(result["name"] as! String == "Eric")
                    XCTAssertTrue(result["location"] as! String == "Portland, OR")
                    promise.fulfill()
                }
            } catch let err {
                print("Err", err)
                }
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
