//
//  ApiError.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case invalidRequest
    case clientSide(Error)
    case notHTTPResponse
    case serverSide(Data?)
    case noData
    case responseDecoding(Error)
}

extension ApiError: Equatable {
    // not ok for production, simplified for testing
    static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        type(of: lhs) == type(of: rhs)
    }
}
