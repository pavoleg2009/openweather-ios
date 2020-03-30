//
//  RequestManagerDefault.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

/// This class responsible for making network requests
final class RequestManagerDefault {
    
    // MARK: Private Properties
    
    private let urlSession: URLSessionProtocol
    
    // MARK: Life Cycle
    
    init(urlSession: URLSessionProtocol = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
}

// MARK: RequestManager
extension RequestManagerDefault: RequestManager {
    
    static var defaultDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
    
    func fetch<Req: ApiRequest>(
        _ request: Req,
        completion: RequestCompletion<Req.ResponseType>?
    ) {
        guard let urlRequest = request.urlRequest else {
            completion?(.failure(ApiError.invalidRequest))
            return
        }
        
        urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            
            if let error = error {
                completion?(.failure(ApiError.clientSide(error)))
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion?(.failure(ApiError.notHTTPResponse))
                return
            }
            
            guard 200..<400 ~= httpResponse.statusCode else {
                completion?(.failure(ApiError.serverSide(data)))
                return
            }
            //
            guard let data = data else {
                completion?(.failure(ApiError.noData))
                return
            }
            
            do {
                let responseEntity = try request.decodeResponse(data: data)
                completion?(.success(responseEntity))
                return
            } catch {
                completion?(.failure(ApiError.responseDecoding(error)))
                return
            }
        }.resume()
    }
}
