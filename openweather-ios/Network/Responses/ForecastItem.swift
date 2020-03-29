//
//  ForecastItem.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

struct ForecastItem {
    let date: Date
    let main: ForecastMain
    let weather: [Weather]
}

extension ForecastItem: Codable {
    
    enum CodingKeys: String, CodingKey {

        case date = "dt"
        case main = "main"
        case weather = "weather"
    }
}
