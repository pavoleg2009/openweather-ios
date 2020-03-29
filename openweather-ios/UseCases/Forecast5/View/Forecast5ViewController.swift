//
//  Forecast5ViewController.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class Forecast5ViewController: UIViewController {
    
    typealias Logic = Forecast5ViewOutput & Forecast5DataSource
    
    var logic: Logic!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = .title
    }
}

// Forecast5ViewInput
extension Forecast5ViewController: Forecast5ViewInput {
    
    func showActivityIndicator() {
        print("!!! \(type(of: self)).\(#function): Show activity indicator here")
    }
    
    func hideActivityIndicator() {
        print("!!! \(type(of: self)).\(#function): Hide activity indicator here")
    }
    
    func showError(errorDescription: String) {
        print("!!! \(type(of: self)).\(#function): Error: \(errorDescription)")
    }
}

private extension String {
    static let title = "Forecast"
}
