//
//  APIManagerTests.swift
//  APIManagerTests
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import XCTest
@testable import openweather_ios

// swiftlint:disable all
final class RequestManagerTests: XCTestCase {
    
//    var sut: RequestManager!
//
//    override func setUp() {
//        sut = RequestManagerDefault()
//    }
//
//    override func tearDown() {
//        sut = nil
//    }

    func test_reuqestManager_shoultCallCompletionWithResult() {
        
        // GIVEN
        let sut = RequestManagerDefault()
        let exp = expectation(description: "request complete")
        let request = ForecastRequest(city: "Munich")
        
        // WHEN
        
        sut.fetch(request) { result in
            switch result {
            case .success(let response):
                print("!!! SUCCESS:", response)
                XCTAssertEqual(response.city?.name, "Munich")
            case .failure(let error):
                XCTFail("Should not fail: \(error)")
            }
            exp.fulfill()
        }
        
        // THEN
        wait(for: [exp], timeout: 2)
    }
    
    func test_reuqestManager_shoultCallCompletionWithError() {
        
        // GIVEN
        let sessionMock: URLSessionProtocol = URLSessionMock(data: nil, response: nil, error: ApiError.noData)
        let sut = RequestManagerDefault(urlSession: sessionMock)
        let exp = expectation(description: "request complete")
        let request = ForecastRequest(city: "Munich")
        
        // WHEN
        
        sut.fetch(request) { result in
            switch result {
            case .success:
                XCTFail("Response with empty data should not succeed")
            case .failure(let error):
                XCTAssertEqual(error as? ApiError, ApiError.noData)
            }
            exp.fulfill()
        }
        
        // THEN
        wait(for: [exp], timeout: 2)
    }

}
// swiftlint:enable all
