//
//  ForecastService.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol ForecastService {
    
    func getForecasts(city: String,
                      completion: RequestCompletion<ForecastRequest.ResponseType>?
    )
}

extension ForecastService {
    func getForecasts(completion: RequestCompletion<ForecastRequest.ResponseType>?
    ) {
        getForecasts(city: "", completion: completion)
    }
}
