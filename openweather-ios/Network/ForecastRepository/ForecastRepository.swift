//
//  ForecastRepository.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 09.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol ForecastRepository: AnyObject {
    
}

final class ForecastRepositoryDefault {
    
    private var forecastServiceAdapters: [ForecastServiceAdapter]
    
    init() {
        self.forecastServiceAdapters = []
    }
}
