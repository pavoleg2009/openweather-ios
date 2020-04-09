//
//  AppDependecyContaner.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

//enum Tabs {
//    case tableView
//    case collectionView
//    
//    var title: String {
//        switch self {
//        case .tableView: return "List"
//        case .collectionView: return "Grid"
//        }
//    }
//}

public class AppDependecyContaner {
    
    init() {}
    
    func makeRootViewController() -> UITabBarController {
        
        let tabBarViewController = UITabBarController()
        
        tabBarViewController.viewControllers = [
            makeListViewController(),
            makeGridViewController()
        ]
        // TODO: Jusst to show updates made to task
        tabBarViewController.selectedIndex = 1
        return tabBarViewController
    }
}

// MARK: - Private nethods
private extension AppDependecyContaner {
    func makeListViewController() -> UIViewController {
        
        let listNavViewController = UINavigationController()
        listNavViewController.tabBarItem = UITabBarItem(title: "List", image: nil, selectedImage: nil)
        let forecast5Module = Forecast5Module()
        listNavViewController.viewControllers = [forecast5Module.viewController]
        
        return listNavViewController
    }
    
    func makeGridViewController() -> UIViewController {
        let gridNavViewController = UINavigationController()
        gridNavViewController.tabBarItem = UITabBarItem(title: "Grid", image: nil, selectedImage: nil)
        let gridModule = GridModule()
        gridNavViewController.viewControllers = [gridModule.viewController]
        return gridNavViewController
    }
}
