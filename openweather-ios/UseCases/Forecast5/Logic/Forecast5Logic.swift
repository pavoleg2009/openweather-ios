//
//  Forecast5Logic.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

typealias VoidClosure = () -> Void

final class Forecast5Logic {
    
    weak var view: Forecast5ViewInput!
    
    // MARK: Forecast5DataSource
    var dayForecasts: [DayForecastDiaplayData] = []
    var cityName: String?
    
    // MARK: Private Properties
    private var forecastServiceAdapters: [ForecastServiceAdapter]
    private var selectedDatasourceIndex = 0
    private var forecastService: ForecastService {
        forecastServiceAdapters[selectedDatasourceIndex]
    }
    
    // MARK: Life Cycle
    init(builderType: ForecastServiceListBuilder.Type = ForecastServiceListBuilderDefault.self) {
        
        self.forecastServiceAdapters = builderType.makeForecastServices()
    }
}

// Forecast5DataSource
extension Forecast5Logic: Forecast5DataSource {
    var datasourceTitles: [String] {
        forecastServiceAdapters.map { $0.title }
    }

    func selectDataSource(index: Int) {
        
        selectedDatasourceIndex = index
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
    }
}

// MARK: - Forecast5ViewOutput
extension Forecast5Logic: Forecast5ViewOutput {
    
    func activate() {
        // view not loaded yet: VC not in the View Hierarchy
        view.configure()
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
    }
}

// NARK: - Private Mathods
private extension Forecast5Logic {
    
    func loadData(completion: VoidClosure?) {
        forecastService.getForecasts(city: .defaultCity) {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let forecastResponse):
                self.handle(successWith: forecastResponse)
            case .failure(let error):
                self.handle(error)
            }
        }
    }
    
    func handle(successWith forecastResponse: ForecastResponse) {
        
        guard let forecasts = forecastResponse.items,
            !forecasts.isEmpty
            else { return }
        
        dayForecasts = Forecast5DisplayDataBuilder().make(from: forecasts)
        cityName = forecastResponse.city?.name
        // TODO: Update city title
        view.update()
    }
    
    func handle(_ error: ApiError) {
        print("!!! \(type(of: self)).\(#function): ERROR: \(error)")
    }
}

private extension String {
    static let defaultCity = "Munich"
}
