//
//  openweather_ios_tests.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import XCTest
@testable import openweather_ios

// swiftlint:disable all
class openweather_ios_tests: XCTestCase {
    
    var sut: OpenWeatherService!
    
    override func setUp() {
        sut = OpenWeatherServiceDefault()
    }

    override func tearDown() {
        sut = nil
    }

    func test_OpenWeatherService_onGetForecast5_shouldReturn30Items() {
        // GIVEN
        
        // WHEN
        
        
        
        // THEN
    }

}
// swiftlint:enable all
