//
//  RootScreenProtocols.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 09.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol RootViewInput {
    func configure()
    func selectTab(_ tab: RootTab)
}

protocol RootViewOutput {
    func activate()
}

protocol RootDataSource {
    var tabs: [RootTab] { get }
}
