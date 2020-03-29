//
//  ForecastMain.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

struct ForecastMain {
    let temp: Decimal
    let feels_like: Decimal
    let pressure: Int
    let humidity: Int
}

extension ForecastMain: Codable {}
