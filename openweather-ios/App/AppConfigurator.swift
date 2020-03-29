//
//  AppConfigurator.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

enum AppConfigurator {
    
    static func configure(for window: UIWindow) {
        
        let navigationControler = UINavigationController()

        let forecast5Module = Forecast5Module()
        navigationControler.viewControllers = [forecast5Module.viewController]
        window.rootViewController = navigationControler
        window.makeKeyAndVisible()
    }
}
