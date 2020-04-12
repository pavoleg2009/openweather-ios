//
//  AppDependencyContainer.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

public class AppDependencyContainer {
    
    init() {}
    
    func makeRootViewController() -> UITabBarController {
            
        let viewController = RootViewController()
        let logic = RootLogic()
        viewController.logic = logic
        logic.view = viewController
        viewController.viewControllers = [
            makeListNavViewController(),
            makeGridNavViewController()
        ]
        logic.activate()
        return viewController
    }
}

// MARK: - Private methods
private extension AppDependencyContainer {
    
    // List Module
    func makeListNavViewController() -> UIViewController {
        
        let navigationController = UINavigationController()
        let viewController = makeListViewController()
        let logic = makeListLogic()
        
        viewController.logic = logic
        logic.view = viewController
        logic.activate()
        
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    func makeListViewController() -> ListViewController {
        return ListViewController(nibName: ListViewController.nibName, bundle: nil)
    }
    
    func makeListLogic() -> ListLogic {
        // TODO: Add dependency
        return ListLogic(servicesBuilderType: ForecastServiceListBuilderDefault.self)
    }
    
    // Grid Module
    func makeGridNavViewController() -> UIViewController {
        
        let navigationController = UINavigationController()
        let viewController = makeGridViewController()
        let logic = makeGridLogic()

        viewController.logic = logic
        logic.view = viewController
        logic.activate()
        
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    func makeGridViewController() -> GridViewController {
        return GridViewController(nibName: GridViewController.nibName, bundle: nil)
    }
    
    func makeGridLogic() -> GridLogic {
        return GridLogic(servicesBuilderType: ForecastServiceListBuilderDefault.self)
    }
}
