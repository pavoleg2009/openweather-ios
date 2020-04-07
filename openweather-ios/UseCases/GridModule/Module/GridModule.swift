//
//  GridModule.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class GridModule {
    
    var viewController: GridViewController
    
    init() {
        let viewController = GridViewController(nibName: "GridViewController", bundle: nil)
        self.viewController = viewController
        
        let logic = GridLogic()

        viewController.logic = logic
        logic.view = viewController
        logic.activate()
    }
}
