//
//  RequestManager.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 25.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

typealias RequestResult<Res> = Result<Res, ApiError>
typealias RequestCompletion<Res> = (RequestResult<Res>) -> Void

/// Conformers of this protocol responsible for making network requests
/// They know nothing about specific endpoints
protocol RequestManager {
    
    func fetch<Req: ApiRequest>(
        _ request: Req,
        completion: RequestCompletion<Req.ResponseType>?
    )
}
