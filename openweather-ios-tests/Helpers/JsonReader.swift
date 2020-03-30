//
//  JsonReader.swift
//  openweather-ios-tests
//
//  Created by Oleg Pavlichenkov on 30.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation
@testable import openweather_ios

final class JsonReader {
    
    func read<T: Decodable>(from fileName: String) throws -> T {
        
        let bundle = Bundle(for: JsonReader.self)
        guard let fileUrl = bundle.url(forResource: fileName, withExtension: "json"),
            case let data = try Data(contentsOf: fileUrl),
            case let decoder = RequestManagerDefault.defaultDecoder,
            case let result = try decoder.decode(T.self, from: data)
            else { fatalError("Could not read \(fileName).json from bundle") }
        return result
    }
}
