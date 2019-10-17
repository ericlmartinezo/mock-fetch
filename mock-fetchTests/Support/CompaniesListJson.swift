//
//  CompaniesListJson.swift
//  mock-fetchTests
//
//  Created by Eric Martinez on 10/11/19.
//  Copyright © 2019 emobile. All rights reserved.
//

import Foundation
import XCTest

let companiesJson = """
    {
       "id": 1,
       "name": "Leanne Graham",
       "username": "Bret",
       "email": "Sincere@april.biz",
       "address": {
           "street": "Kulas Light",
           "suite": "Apt. 556",
           "city": "Gwenborough",
           "zipcode": "92998-3874",
           "geo": {
               "lat": "-37.3159",
               "lng": "81.1496"
           }
       },
        "phone": "1-770-736-8031 x56442",
        "website": "hildegard.org",
        "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
        }
}
""".data(using: .utf8)!

struct PdxTech: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}

struct Address: Decodable {
    let address: AddressDetails
}

struct AddressDetails: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct Company: Decodable {
    let company: CompanyArray
}

struct CompanyArray: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
}
