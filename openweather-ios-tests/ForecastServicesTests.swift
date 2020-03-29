//
//  ForecastServicesTests.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import XCTest
@testable import openweather_ios

final class ForecastServicesTests: XCTestCase {

    func testExample() throws {
        
        // GIVEN
        let service: ForecastService = ForecastServiceDefault()
        let exp = expectation(description: "request complete")
        
        // WHEN
        service.getForecasts(city: "Munich") { result in
            print("!!! \(type(of: self)).\(#function): \(result)")
            exp.fulfill()
        }
        
        // THEN
        wait(for: [exp], timeout: 2)
    }

}
