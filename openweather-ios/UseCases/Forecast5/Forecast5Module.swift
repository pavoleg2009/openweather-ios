//
//  Forecast5Module.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class Forecast5Module {
    
    var viewController: Forecast5ViewController
    
    init() {
        let viewController = Forecast5ViewController(nibName: "Forecast5ViewController", bundle: nil)
        self.viewController = viewController
        
        let forecastService = ForecastServiceDefault()
        let logic = Forecast5Logic(forecastService: forecastService)
        
        viewController.logic = logic
        logic.view = viewController
        
    }
}
