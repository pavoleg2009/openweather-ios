//
//  Forecast5DisplayDataBuilder.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

/// build display data for 5 days forecast from array of [ForecastItem]
struct Forecast5DisplayDataBuilder {
    
    // MARK: Private Properties
    private let calendar: Calendar
    
    // MARK: Life Cycle
    init(calendar: Calendar = Calendar.current) {
        self.calendar = calendar
    }
    
    /// separaing list of forecasts by day
    
    func make(from items: [ForecastItem]) -> [DayForecastDiaplayData] {
        
        var daysDisplayData: [DayForecastDiaplayData] = []
        
        var oneDayDisplayData: DayForecastDiaplayData!
        
        var currentDay: String?
        
        for forecastItem in items {

            guard let forecastDisplayData = ForecastDisplayData(forecastItem: forecastItem,
                                                                using: calendar)
                else { continue }
            
            if forecastDisplayData.day == currentDay {
                oneDayDisplayData.forecastItems.append(forecastDisplayData)
            } else {
                // on the iteration oneDayDisplayData will be nill
                if let oneDayDisplayData = oneDayDisplayData {
                    daysDisplayData.append(oneDayDisplayData)
                }
                    
                currentDay = forecastDisplayData.day
                
                oneDayDisplayData = DayForecastDiaplayData(
                    dateString: forecastDisplayData.date,
                    forecastItems: [forecastDisplayData])
            }
        }
        // append last day
        daysDisplayData.append(oneDayDisplayData)
        
        return daysDisplayData
    }
}

private extension ForecastDisplayData {
    
    init?(forecastItem: ForecastItem, using calendar: Calendar) {
        
        guard
            let day = calendar.dateComponents([.day], from: forecastItem.date).day,
            let hour = calendar.dateComponents([.hour], from: forecastItem.date).hour,
            let iconName = forecastItem.weather.first?.icon,
            let weatherIcon = UIImage(named: iconName),
            let description = forecastItem.weather.first?.description
            else { return nil }
        
        self.temperature = "\(forecastItem.main.temp) Cel"
        self.description = description
        self.time = "\(hour) hours"
        self.day = "\(day)"
        self.date = "\(forecastItem.date)"
        self.icon = weatherIcon
    }
}
