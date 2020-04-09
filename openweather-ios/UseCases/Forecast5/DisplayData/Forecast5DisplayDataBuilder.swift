//
//  Forecast5DisplayDataBuilder.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

// TODO: move to DI Container?
let itemsInFullDay = 8

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
            if forecastDisplayData.monthDay != currentDay {
                // Add display data for previous day to resulting array.
                // On the 1st iteration oneDayDisplayData will be nill
                // because there were no previous day
                if let currentDayDisplayData = currentDayDisplayData {
                    daysDisplayData.append(currentDayDisplayData)
                }
                
                currentDayDisplayData = DayForecastDiaplayData(forecastItems: [forecastDisplayData])
                currentDay = forecastDisplayData.monthDay
            } else {
                // just add item to the current day
                currentDayDisplayData.forecastItems.append(forecastDisplayData)
            }
        }
        // append last day
        daysDisplayData.append(currentDayDisplayData)
        
        return daysDisplayData
    }
    
    func makeGridItems(from items: [ForecastItem]
    ) -> [[GridItem]] {
        
        // ForecastItem -> ForecastDisplayData -> [monthDay: [ForecastDisplayData]]
        let itemsGroupedByDay = items
            .compactMap { ForecastDisplayData(forecastItem: $0, using: calendar) }
            .reduce(into: [:]) { $0[$1.monthDay, default:[]].append($1) }
        
        // sorted key -> [[ForecastDisplayData]] sorted by day -> [[GridItem]]
        let gridItems = itemsGroupedByDay
            .keys.sorted() // sort keys
            .compactMap { itemsGroupedByDay[$0] } // map sorted key to
            .map { $0.map { GridItem.item($0) } }
        
        let fullGridItems = gridItems
            .enumerated()
            .map { fill($1, toCount: itemsInFullDay, inFront: $0 == 0) }

        return fullGridItems
    }
    
    private func fill(_ arr: [GridItem], toCount tagetCount: Int, inFront: Bool) -> [GridItem] {
        
        let emptyItems = [GridItem](repeating: .emptyCell, count: tagetCount - arr.count)
        
        return inFront
            ? emptyItems + arr
            : arr + emptyItems
    }
}
// MARK: Private
private extension ForecastDisplayData {
    
    static var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
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
        
        guard
            let month = calendar.dateComponents([.month], from: forecastItem.date).month,
            let day = calendar.dateComponents([.day], from: forecastItem.date).day,
            let iconName = forecastItem.weather.first?.icon,
            let weatherIcon = UIImage(named: iconName),
            let description = forecastItem.weather.first?.description
            else { return nil }
        
        self.temperature = "\(Int(forecastItem.main.temp))°"
        self.feelsLike = "\(String.fellsLike)\(Int(forecastItem.main.feelsLike))°"
        self.description = description
        self.time = ForecastDisplayData.timeFormatter.string(from: forecastItem.date)
        self.monthDay = String(format: "%02d%02d", month, day ) // used to group cells by date
        self.date = ForecastDisplayData.dateFormatter.string(from: forecastItem.date)
        self.icon = weatherIcon
    }
}

private extension String {
    static let fellsLike = "Feels like: "
}
