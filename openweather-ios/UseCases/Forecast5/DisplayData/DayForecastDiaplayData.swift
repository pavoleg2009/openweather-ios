//
//  DayForecastDiaplayData.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

/// Forecast data for one day
struct DayForecastDiaplayData {
    let dateString: String
    var forecastItems: [ForecastDisplayData]
}
