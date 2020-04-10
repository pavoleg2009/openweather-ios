//
//  ForecastServiceAdapter.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

/// Allows add title for Service to be shown in UI for selection
final class ForecastServiceAdapter {
    
    // MARK: Private Properties
    private let service: ForecastService
    
    // MARK: Internal Properties
    var title: String
    
    // MARK: Life Cycle
    init(title: String,
         service: ForecastService
    ) {
        self.title = title
        self.service = service
    }
}

extension ForecastServiceAdapter: ForecastService {
    func getForecasts(city: String, completion: RequestCompletion<ForecastRequest.ResponseType>?
    ) {    
        return service.getForecasts(city: city,
                                    completion: completion)
    }
}
