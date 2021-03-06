//
//  ForecastServiceJsonTests.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import XCTest
@testable import openweather_ios

final class ForecastServiceJsonTests: XCTestCase {

    func test_getForecastFromLocalJson_shouldReturn40Items() throws {
        
        // GIVEN
        let sut: ForecastService = ForecastServiceJson()
        let exp = expectation(description: "Request complete")
        let expectedItemsCount = 40
        
        // WHEN
        sut.getForecasts { result in
            
            // THEN
            switch result {
            case .success(let forecastResponse):
                XCTAssertEqual(forecastResponse.items?.count, expectedItemsCount)
            case .failure:
                XCTFail("Success expected")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 2)
    }

}
