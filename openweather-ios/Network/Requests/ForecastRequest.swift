//
//  ForecastRequest.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 25.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

struct ForecastRequest: ApiRequest {
    
    typealias ResponseType = ForecastResponse
    
    var path = "forecast"
    
    var params: [String: String] {
        [
            "appid": "9b3f2f9d2a2e963aa76b00e07a59227c",
            "mode": "json(UNITS)",
            "units": "metric",
            "q": city
        ]
    }
    
    var method = HTTPMethod.get
    
    // MARK: Private Properties
    private var city: String
    
    // MARK: Life Cycle
    init(city: String) {
        self.city = city
    }
  
}
