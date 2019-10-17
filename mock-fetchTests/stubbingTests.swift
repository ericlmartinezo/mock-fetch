//
//  File.swift
//  mock-fetchTests
//
//  Created by Eric Martinez on 9/25/19.
//  Copyright © 2019 emobile. All rights reserved.
//

import Foundation
import XCTest
// This test sample makes a GET network request
class stubbingTests: XCTestCase {
    
    func testGitUserData() {
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
    
    func testNoaaData() {
        
        guard let noaaUrlPortland = URL(string: "http://forecast.weather.gov/MapClick.php?lat=45.5361588&lon=-122.8328414&FcstType=json") else { return }
        
        let promise = expectation(description: "NOAA Weather for Portland OR") // Used fulfill at the end of request
        print(promise)
        
        URLSession.shared.dataTask(with: noaaUrlPortland) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) // mutableContainers why?

                if let result = json as? NSDictionary {
                    XCTAssertTrue(result["srsName"] as! String == "WGS 1984")
                    XCTAssertTrue(result["operationalMode"] as! String == "Production")
                    XCTAssertTrue(result["productionCenter"] as! String == "Portland, OR")
                    XCTAssertTrue(result["moreInformation"] as! String == "http://weather.gov")
                    promise.fulfill()
                    
                    let weather_pdx = result.value(forKeyPath: "location") as Any
//                    let weather_pdx_region_0 = (weather_pdx as AnyObject).value(forKeyPath: "region")
                    let weather_pdx_region = (weather_pdx as AnyObject).value(forKeyPath: PortlandLocationKey.portlandRegion.rawValue)
                    let weather_pdx_wfo = (weather_pdx as AnyObject).value(forKeyPath: PortlandLocationKey.portlandWFO.rawValue)
                    let weather_pdx_zone = (weather_pdx as AnyObject).value(forKeyPath: PortlandLocationKey.portlandZone.rawValue)
                    let weather_pdx_areaDescription = (weather_pdx as AnyObject).value(forKeyPath: PortlandLocationKey.portlandAreaDescription.rawValue)
                    
//                    XCTAssertTrue((weather_pdx_region_0 != nil))
                    XCTAssertTrue(weather_pdx_region as! String == PortlandLocationValue.regionValue.rawValue)
                    XCTAssertTrue(weather_pdx_wfo as! String == PortlandLocationValue.wfoValue.rawValue)
                    XCTAssertTrue(weather_pdx_zone as! String == PortlandLocationValue.zoneValue.rawValue)
                    XCTAssertTrue(weather_pdx_areaDescription as! String == PortlandLocationValue.areaDescription.rawValue)
    
                    
//                    print(weather_pdx_areaDescription!)
                }
            } catch let err {
                print("Err", err)
            }
            
            }.resume()
        waitForExpectations(timeout: 7, handler: nil)
    }

    func testJsonData() {
        let decoder = JSONDecoder()
        let companyInfo = try! decoder.decode(PdxTech.self, from: companiesJson)
        if companyInfo.id != 1 {
        XCTFail("Company id not equal to expected value")
        }
    }
        
    func testDictionary() {
        let decoder = JSONDecoder()
// test array
        let companyInfo = try! decoder.decode(PdxTech.self, from: companiesJson)
        if companyInfo.username != "Bret" {
        XCTFail("Username not equal to expected value")
        } else {
            print(companyInfo.username)
        }
        print(companyInfo.id)
// access and validate nested Dictionary
        let addressFamily = try! decoder.decode(Address.self, from: companiesJson)
        let companyProperties = addressFamily.address
        print(companyProperties.city)
        print(companyProperties.street,"St.")
        print(companyProperties.suite)
        print(companyProperties.zipcode)
    }
    
    func testCompanyArrayProperties(property: String) {
        let decoder = JSONDecoder()
        let companyInfo = try! decoder.decode(Company.self, from: companiesJson)
        let companyArrayValues = companyInfo.company
        print(companyArrayValues.bs)
    }
}
