//
//  test_Forecast5Response.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import XCTest
import Foundation

@testable import openweather_ios
// swiftlint:disable all
class test_Forecast5Response: XCTestCase {
    
    let session = URLSession.shared
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=Munich&mode=json(UNITS)&appid=9b3f2f9d2a2e963aa76b00e07a59227c&&units=metric"
        let url = URL(string: urlString)!
        
        let expectation = XCTestExpectation(description: "wait for request completion")
        let task = session.dataTask(with: url) { (data, response, error) in
            
            let coder = JSONDecoder()
            coder.dateDecodingStrategy = .secondsSince1970
            
            do {
                let response = try coder.decode(Forecast5Response.self, from: data!)
                print(response.items!.first!)
                expectation.fulfill()
            } catch {
                XCTFail(String(describing: error))
                expectation.fulfill()
            }
            
        }
        task.resume()
        wait(for: [expectation], timeout: 2)
    }

}
// swiftlint:enable all
