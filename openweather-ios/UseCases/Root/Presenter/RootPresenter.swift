//
//  RootPresenter.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 09.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class RootPresenter {
    
    weak var view: RootViewInput!
}

// MARK: RootDataSource
extension RootPresenter: RootDataSource {
    var tabs: [RootTab] {
        RootTab.allCases
    }
}

// MARK: RootViewOutput
extension RootPresenter: RootViewOutput {
    func activate() {
        view.configure()
        view.selectTab(.grid)
    }
}
