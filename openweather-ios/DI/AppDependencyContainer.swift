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
        let presenter = RootPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        viewController.viewControllers = [
            makeListNavViewController(),
            makeGridNavViewController()
        ]
        presenter.activate()
        return viewController
    }
}

// MARK: - Private methods
private extension AppDependencyContainer {
    
    // List Module
    func makeListNavViewController() -> UIViewController {
        
        let navigationController = UINavigationController()
        let viewController = makeListViewController()
        let presenter = makeListPresenter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.activate()
        
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    func makeListViewController() -> ListViewController {
        return ListViewController(nibName: ListViewController.nibName, bundle: nil)
    }
    
    func makeListPresenter() -> ListPresenter {
        
        return ListPresenter(servicesBuilderType: ForecastServiceListBuilderDefault.self)
    }
    
    // Grid Module
    func makeGridNavViewController() -> UIViewController {
        
        let navigationController = UINavigationController()
        let viewController = makeGridViewController()
        let presenter = makeGridPresenter()

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.activate()
        
        navigationController.viewControllers = [viewController]
        return navigationController
    }
    
    func makeGridViewController() -> GridViewController {
        return GridViewController(nibName: GridViewController.nibName, bundle: nil)
    }
    
    func makeGridPresenter() -> GridPresenter {
        return GridPresenter(servicesBuilderType: ForecastServiceListBuilderDefault.self)
    }
}
