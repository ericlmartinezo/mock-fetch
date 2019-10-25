//
//  NetworkRequestHelper.swift
//  mock-fetch
//
//  Created by Eric Martinez on 10/21/19.
//  Copyright © 2019 emobile. All rights reserved.
//

import Foundation

enum NoaaPortlandUrl: String {
    case urlPortlandUrl = "http://forecast.weather.gov/MapClick.php?lat=45.5361588&lon=-122.8328414&FcstType=json"
}

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


func noaaRequest() {
    guard let noaaUrlPortland = URL(string: NoaaPortlandUrl.urlPortlandUrl.rawValue) else { return }

    URLSession.shared.dataTask(with: noaaUrlPortland) { (data, response
        , error) in
        guard let data = data else { return }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)

            if let result = json as? NSDictionary {
                
            let weather_pdx = result.value(forKeyPath: "location") as Any
            let weather_pdx_region = (weather_pdx as AnyObject).value(forKeyPath:
                PortlandLocationKey.portlandRegion.rawValue)
                print(weather_pdx_region!)
            }
        } catch let err {
            print("Err", err)
        }
    }
}
