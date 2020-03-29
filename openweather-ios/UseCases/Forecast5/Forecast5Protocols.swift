//
//  Forecast5Protocols.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol Forecast5ViewInput: AnyObject {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showError(errorDescription: String)
}

protocol Forecast5ViewOutput: AnyObject {
    func activate()
}

protocol Forecast5DataSource: AnyObject {
    
}
