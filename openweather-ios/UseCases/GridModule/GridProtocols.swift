//
//  GridProtocols.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

protocol GridViewInput: AnyObject {
    
    func configure()
    func showActivityIndicator()
    func hideActivityIndicator()
    func showError(errorDescription: String)
    func update()
}

protocol GridViewOutput: AnyObject {
    func activate()
}

protocol GridDataSource: AnyObject {
    
    var datasourceTitles: [String] { get }
    
    var rowCount: Int { get }
    var colCount: Int { get }
    
    func selectDataSource(index: Int)
    
    func getItemsCount(for section: Int) -> Int
    func getGridItem(for indexPath: IndexPath) -> GridItem?
}
