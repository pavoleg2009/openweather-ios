//
//  GridItem.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 09.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

enum GridItem {
    case emptyCell
    case item(ForecastDisplayData)
}

extension GridItem: WeatherCellDisplayData {
    var dateString: String? {
        switch self {
        case .emptyCell:
            return nil
        case let .item(displayData):
            return "\(displayData.date) \(displayData.time)"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .emptyCell:
            return nil
        case let .item(displayData):
            return displayData.icon
        }
    }
    
    var tempString: String? {
        switch self {
        case .emptyCell:
            return "⇢"
        case let .item(displayData):
            return "\(displayData.temperature)"
        }
    }
}
