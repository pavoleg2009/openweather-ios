//
//  Forecast5Logic.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class Forecast5Logic: Forecast5DataSource {
    
    weak var view: Forecast5ViewInput!
    
    // MARK: Forecast5DataSource
    
    // MARK: Private Properties
    private var forecastService: ForecastService
    
    // MARK: Life Cycle
    init(forecastService: ForecastService) {
        self.forecastService = forecastService
    }
}

extension Forecast5Logic: Forecast5ViewOutput {

}
