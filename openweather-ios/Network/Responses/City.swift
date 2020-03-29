//
//  City.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

struct City {
    let id: Int
    let name: String
    let country: String
    let timezoneSec: Int
}

extension City: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, name, country
        case timezoneSec = "timezone"
    }
}
