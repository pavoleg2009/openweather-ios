//
//  ApiRequestTests.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 25.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation
import XCTest

@testable import openweather_ios

// swiftlint:disable all
final class ForecastRequestTests: XCTestCase {

    func test_urlRequest_ShouldGenerateRequestWithProperURL() {
        
        // GIVEN
        let expectedURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?appid=9b3f2f9d2a2e963aa76b00e07a59227c&mode=json(UNITS)&q=New%20York&units=metric")

        let q = "New York"
       
        // WHEN
        let request = ForecastRequest(city: q).urlRequest!
        
        // THEN
        print(request.url!)
        XCTAssertEqual(
            URLComponents(url: request.url!, resolvingAgainstBaseURL: false),
            URLComponents(url: expectedURL!, resolvingAgainstBaseURL: false)
        )
    }

}

// swiftlint:enable all
