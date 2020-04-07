//
//  GridProtocols.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol GridViewInput: AnyObject {
    func configure()
}

protocol GridViewOutput: AnyObject {
    func activate()
}

protocol GridDataSoutce: AnyObject {
    
}
