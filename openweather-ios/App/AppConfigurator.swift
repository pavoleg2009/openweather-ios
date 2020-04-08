//
//  AppConfigurator.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

enum Tabs {
    case tableView
    case collectionView
    
    var title: String {
        switch self {
        case .tableView: return "List"
        case .collectionView: return "Grid"
        }
    }
    
//    var factory: TabFactory
}

/// Configures initial app state
enum AppConfigurator {
    
    static func configure(for window: UIWindow
    ) {
        
        let rootTabBarViewController = UITabBarController()
        
        // Tab 1: Table View
        let listNavViewController = UINavigationController()
        listNavViewController.tabBarItem = UITabBarItem(title: "List", image: nil, selectedImage: nil)
        let forecast5Module = Forecast5Module()
        listNavViewController.viewControllers = [forecast5Module.viewController]
        
        // Tab 2: Collection View
        let gridNavViewController = UINavigationController()
        gridNavViewController.tabBarItem = UITabBarItem(title: "Grid", image: nil, selectedImage: nil)
        let gridModule = GridModule()
        gridNavViewController.viewControllers = [gridModule.viewController]
        
        rootTabBarViewController.viewControllers = [
            listNavViewController,
            gridNavViewController
        ]
        rootTabBarViewController.selectedIndex = 1
        
        window.rootViewController = rootTabBarViewController
        window.makeKeyAndVisible()
    }
}
