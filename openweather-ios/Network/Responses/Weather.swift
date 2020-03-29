//
//  Weather.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

struct Weather {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

extension Weather: Codable {}
