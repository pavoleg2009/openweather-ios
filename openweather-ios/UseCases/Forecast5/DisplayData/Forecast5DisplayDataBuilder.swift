//
//  Forecast5DisplayDataBuilder.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

/// Builds display data for 5 days forecast from array of ForecastItem.
struct Forecast5DisplayDataBuilder {
    
    // MARK: Private Properties
    private let calendar: Calendar
    private let timezoneOffset = TimeZone.current.secondsFromGMT()
    
    // MARK: Life Cycle
    init(calendar: Calendar = Calendar.current
    ) {
        self.calendar = calendar
    }
    
    // grouping list of forecasts by day
    func make(from items: [ForecastItem]
    ) -> [DayForecastDiaplayData] {
        
        var daysDisplayData: [DayForecastDiaplayData] = []
        var currentDay: String?
        var currentDayDisplayData: DayForecastDiaplayData!
        
        for forecastItem in items {

            guard let forecastDisplayData = ForecastDisplayData(forecastItem: forecastItem, using: calendar)
                else { continue }
            
            // if we got the first element of the next day
            if forecastDisplayData.day != currentDay {
                // Add display data for previous day to resulting array.
                // On the 1st iteration oneDayDisplayData will be nill
                // because there were no previous day
                if let currentDayDisplayData = currentDayDisplayData {
                    daysDisplayData.append(currentDayDisplayData)
                }
                
                currentDayDisplayData = DayForecastDiaplayData(forecastItems: [forecastDisplayData])
                currentDay = forecastDisplayData.day
            } else {
                // just add item to the current day
                currentDayDisplayData.forecastItems.append(forecastDisplayData)
            }
        }
        // append last day
        daysDisplayData.append(currentDayDisplayData)
        
        return daysDisplayData
    }
}
// MARK: Private
private extension ForecastDisplayData {
    
    static var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:MM"
        return formatter
    }()
    
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }()
    
    init?(forecastItem: ForecastItem, using calendar: Calendar
    ) {
        guard let timeZone = TimeZone(secondsFromGMT: 0) else { return nil }
        var calendar = calendar
        calendar.timeZone = timeZone
        
        guard let day = calendar.dateComponents([.day], from: forecastItem.date).day,
            let hour = calendar.dateComponents([.hour], from: forecastItem.date).hour,
            let iconName = forecastItem.weather.first?.icon,
            let weatherIcon = UIImage(named: iconName),
            let description = forecastItem.weather.first?.description
            else { return nil }
        
        self.temperature = "\(Int(forecastItem.main.temp)) °"
        self.feelsLike = "\(String.fellsLike)\(Int(forecastItem.main.feelsLike)) °"
        self.description = description
        self.time = "\(hour):00"
        self.day = "\(day)" // used to group cells by date
        self.date = ForecastDisplayData.dateFormatter.string(from: forecastItem.date)
        self.icon = weatherIcon
    }
}

private extension String {
    static let fellsLike = "Feels like: "
}
