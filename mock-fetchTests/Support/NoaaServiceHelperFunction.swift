//
//  NoaaServiceHelperFunction.swift
//  mock-fetchTests
//
//  Created by Eric Martinez on 9/27/19.
//  Copyright © 2019 emobile. All rights reserved.
//

import Foundation
import XCTest

enum PortlandLocationKey: String {
    case portlandRegion = "region"
    case portlandWFO = "wfo"
    case portlandZone = "zone"
    case portlandAreaDescription = "areaDescription"
    }


enum PortlandLocationValue: String {
    case regionValue = "wrh"
    case wfoValue = "PQR"
    case zoneValue = "ORZ006"
    case areaDescription = "3 Miles NNW Cedar Hills OR"
}


func returnLocationKeyValues() {
    
}
