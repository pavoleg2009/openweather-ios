//
//  ForecastResponse.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

struct ForecastResponse {
    
    let code: String?
    let message: Int?
    let count: Int?
    let items: [ForecastItem]?
    let city: City?
}

extension ForecastResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
        case count = "cnt"
        case items = "list"
        case city
    }
}
