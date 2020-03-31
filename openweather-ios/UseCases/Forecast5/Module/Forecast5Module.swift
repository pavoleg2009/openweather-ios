//
//  Forecast5Module.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

/// Module is responsible for instantiating ViewController, Logic,
/// managing module dependencies, binding module items (VC, Logic, etc)
/// Usually responsible for showing other modules (screens)
final class Forecast5Module {
    
    var viewController: Forecast5ViewController
    
    init() {
        let viewController = Forecast5ViewController(nibName: "Forecast5ViewController", bundle: nil)
        self.viewController = viewController
        
        let logic = Forecast5Logic()
        
        viewController.logic = logic
        logic.view = viewController
        logic.activate()
    }
}
