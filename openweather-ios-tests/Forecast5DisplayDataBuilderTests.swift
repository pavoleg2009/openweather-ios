//
//  Forecast5DisplayDataBuilderTests.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import XCTest
@testable import openweather_ios

class Forecast5DisplayDataBuilderTests: XCTestCase {

    func test_Forecast5DisplayDataBuilder_shouldMakeItemsFor5days() throws {
        // GIVEN
        // Load from json
        let jsonFileName = "munich_2020_03_30_17_35"
        let response: ForecastResponse = try JsonReader().read(from: jsonFileName)
        let items: [ForecastItem] = response.items ?? []
        
        // WHEN
        let dayForecasts = Forecast5DisplayDataBuilder().make(from: items)
        
        // THEN
        // in each response we are waitng for forecasts of 5-6 days
        // when you request after 9PM (GMT), you got 5 full day forecatst by 8 items
        // starting with forecast for 12AM for the next day => 40 items total
        // if you request earlier, you'll have _x_ < 8 items for current date,
        // 8 for each other day and 8 - x for the last day.
        XCTAssert(5...6 ~= dayForecasts.count)
        
        // we have 2 items in munich_2020_03_30_17_35.json for 30.03
        XCTAssertEqual(dayForecasts[0].forecastItems.count, 2)
        XCTAssertEqual(dayForecasts[1].forecastItems.count, 8)
        XCTAssertEqual(dayForecasts[4].forecastItems.count, 8)
        XCTAssertEqual(dayForecasts[5].forecastItems.count, 8 - 2)
    }

}
