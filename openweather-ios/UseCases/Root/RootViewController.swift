//
//  RootViewController.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 09.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class RootViewController: UITabBarController {
    
    typealias Logic = RootViewOutput & RootDataSource
    
    // MARK: Internal Properties
    var logic: Logic!
}

// MARK: - RootViewInput
extension RootViewController: RootViewInput {
    
    func configure() {
        
        tabBar.tintColor = .primaryBrandColor
        logic.tabs
            .map { UITabBarItem(title: $0.title, image: $0.icon, selectedImage: nil) }
            .enumerated()
            .forEach { index, item in
                guard index < viewControllers?.count ?? 0 else { return }
                viewControllers?[index].tabBarItem = item
            }
    }
    
    func selectTab(_ tab: RootTab) {
        // Just to show updates made
        selectedIndex = tab.rawValue
    }
    
}
