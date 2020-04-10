//
//  Forecast5Protocols.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol ListViewInput: AnyObject {
    
    func configure()
    func showActivityIndicator()
    func hideActivityIndicator()
    func showError(errorDescription: String)
    func update()
}

protocol ListViewOutput: AnyObject {
    func activate()
}

protocol Forecast5DataSource: AnyObject {
    
    var datasourceTitles: [String] { get }
    var cityName: String? { get }
    
    func getSectionsCount() -> Int
    func getItemsCount(for section: Int) -> Int
    func getHeaderTitle(for section: Int) -> String?
    func getForecastDisplayData(for indexPath: IndexPath) -> ForecastDisplayData?
    func selectDataSource(index: Int)
}
