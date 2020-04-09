//
//  RootLogic.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 09.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class RootLogic {
    
    var view: RootViewInput!
}

// MARK: RootDataSource
extension RootLogic: RootDataSource {
    var tabs: [RootTab] {
        RootTab.allCases
    }
}

// MARK: RootViewOutput
extension RootLogic: RootViewOutput {
    func activate() {
        view.configure()
        view.selectTab(.grid)
    }
}
