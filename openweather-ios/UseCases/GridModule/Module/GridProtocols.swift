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
    var numberOfItems: Int { get }
    var displayData: [[GridItem]] { get }
    
    // TODO: Rename
    func getHeaderTitle(for section: Int) -> String?
}
