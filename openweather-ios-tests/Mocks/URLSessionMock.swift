//
//  URLSessionMock.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation
@testable import openweather_ios

final class URLSessionMock: URLSessionProtocol {
    
    // MARK: Instance properties
    var url: URL?
    var request: URLRequest?
    var dataTaskMock: URLSessionDataTaskMock
    
    // MARK: Life cycle
    init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        dataTaskMock = URLSessionDataTaskMock()
        dataTaskMock.taskResponse = (data, response, error)
    }
    
//    public convenience init?(jsonDict: [String: Any], response: URLResponse? = nil, error: Error? = nil) {
//        guard let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else { return nil }
//        self.init(data: data, response: response, error: error)
//    }
    
    // MARK: Instance methods
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        self.request = request
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }
    
//    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//
//        self.url = url
//        self.dataTaskMock.completionHandler = completionHandler
//        return self.dataTaskMock
//    }
    
}
