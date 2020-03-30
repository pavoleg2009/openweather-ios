//
//  ForecastServiceListBuilder.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol ForecastServiceListBuilder {
    static func makeForecastServices() -> [ForecastServiceAdapter]
}

enum ForecastServiceListBuilderDefault: ForecastServiceListBuilder {
    
    static func makeForecastServices() -> [ForecastServiceAdapter] {
        return [
            ForecastServiceAdapter(title: .online,
                                   service: ForecastServiceDefault()),
            ForecastServiceAdapter(title: .json,
                                   service: ForecastServiceJson())
        ]
    }
}

private extension String {
    static let online = "Online API"
    static let json = "Stored JSON"
}
