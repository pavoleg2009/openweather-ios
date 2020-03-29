//
//  OpenWeatherServiceDefault.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class ForecastServiceDefault {
    
    // MARK: Private Properties
    private let requestManager: RequestManager
    
    // MARK: Life Cycle
    init(requestManager: RequestManager = RequestManagerDefault()) {
        self.requestManager = requestManager
    }
}

extension ForecastServiceDefault: ForecastService {
    
    func getForecasts(city: String,
                      completion: RequestCompletion<ForecastRequest.ResponseType>?
    ) {
        let forecastRequest = ForecastRequest(city: city)
        requestManager.fetch(forecastRequest, completion: completion)
    }
}
