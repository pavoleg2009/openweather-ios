//
//  AppDelegate.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 24.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let injectionContaner = AppDependecyContaner()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
//        let rootViewController = injectionContaner.makeRootViewController()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        AppConfigurator.configure(for: window)
        
        return true
    }
}
