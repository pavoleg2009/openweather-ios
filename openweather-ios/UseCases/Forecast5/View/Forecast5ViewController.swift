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

extension Forecast5ViewController: Forecast5ViewInput {
    
}

private extension String {
    static let title = "Forecast"
}
