//
//  Forecast5Logic.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class Forecast5Logic: Forecast5DataSource {
    
    weak var view: Forecast5ViewInput!
    
    // MARK: Forecast5DataSource
    
    // MARK: Private Properties
    private var forecastService: ForecastService
    
    // MARK: Life Cycle
    init(forecastService: ForecastService) {
        self.forecastService = forecastService
    }
}

extension Forecast5Logic {
    
    func activate() {
        
        view.showActivityIndicator()
        forecastService.getForecasts(city: .defaultCity) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let forecastResponse):
                self.handle(successWith: forecastResponse)
            case .failure(let error):
                self.handle(error)
            }
            self.view.hideActivityIndicator()
        }
    }
}

// MARK: - Forecast5ViewOutput
extension Forecast5Logic: Forecast5ViewOutput {

}

// NARK: - Private Mathods
private extension Forecast5Logic {
    func handle(successWith forecastResponse: ForecastResponse) {
        print("!!! \(type(of: self)).\(#function): forecastResponse: \(forecastResponse)")
    }
    
    func handle(_ error: ApiError) {
        print("!!! \(type(of: self)).\(#function): ERROR: \(error)")
    }
}

private extension String {
    static let defaultCity = "Munich"
}
