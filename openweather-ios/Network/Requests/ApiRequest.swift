//
//  ApiRequest.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol ApiRequest {
    
    associatedtype ResponseType: Codable
    
    var path: String { get }
    var params: [String: String] { get }
    var method: HTTPMethod { get }
    var urlRequest: URLRequest? { get }
    var decoder: JSONDecoder { get }
    
    func decodeResponse(data: Data) throws -> ResponseType
}

extension ApiRequest {
    
    var urlRequest: URLRequest? {
        
        let baseURL = "https://api.openweathermap.org/data/2.5/\(path)"
        
        var url: URL?
        
        var urlComponents = URLComponents(string: baseURL)
        if urlComponents?.queryItems == nil {
            urlComponents?.queryItems = []
        }
        
        if urlComponents != nil {
            for (key, value) in params
                // sort by keys to be able to test url
                .sorted(by: { $0.key < $1.key }) {
                urlComponents?.queryItems?.append(
                    URLQueryItem(name: key, value: value)
                )
            }
            url = urlComponents?.url
        } else {
            url = URL(string: baseURL)
        }
        if url == nil {
            if let urlStr = baseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                url = URL(string: urlStr)
            }
        }
        guard let requestURL = url else { return nil }
        
        var urlRequest = URLRequest(url: requestURL)

        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    // default response decoder
    var decoder: JSONDecoder {
        return RequestManagerDefault.defaultDecoder
    }
    
    func decodeResponse(data: Data) throws -> ResponseType {
        return try decoder.decode(ResponseType.self, from: data)
    }
}
