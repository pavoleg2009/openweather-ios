//
//  AppDependecyContaner.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

public class AppDependecyContaner {
    
    init() {}
    
    func makeRootViewController() -> UITabBarController {
            
        let viewController = RootViewController()
        let logic = RootLogic()
        viewController.logic = logic
        logic.view = viewController
        viewController.viewControllers = [
            makeListViewController(),
            makeGridViewController()
        ]
        logic.activate()
        return viewController
    }
}

// MARK: - Private nethods
private extension AppDependecyContaner {
    func makeListViewController() -> UIViewController {
        
        let listNavViewController = UINavigationController()
        let forecast5Module = Forecast5Module()
        listNavViewController.viewControllers = [forecast5Module.viewController]
        return listNavViewController
    }
    
    func makeGridViewController() -> UIViewController {
        
        let gridNavViewController = UINavigationController()
        let gridModule = GridModule()
        gridNavViewController.viewControllers = [gridModule.viewController]
        return gridNavViewController
    }
}
