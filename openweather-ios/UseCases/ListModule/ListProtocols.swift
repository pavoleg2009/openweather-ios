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

protocol ListDataSource: AnyObject {
    
    var cityName: String? { get }
    var datasourceTitles: [String] { get }
    
    func selectDataSource(index: Int)
    
    func getSectionsCount() -> Int
    func getItemsCount(for section: Int) -> Int
    func getHeaderTitle(for section: Int) -> String?
    func getForecastDisplayData(for indexPath: IndexPath) -> (type: ForecastItemType, data: ForecastDisplayData)?
    
}
