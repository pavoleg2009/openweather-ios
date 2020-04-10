//
//  ListLogic.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

typealias VoidClosure = () -> Void

final class ListLogic {
    
    weak var view: ListViewInput!
    
    // MARK: ListDataSource
    private var dayForecasts: [[ForecastDisplayData]] = []
    var cityName: String?
    
    // MARK: Private Properties
    private var forecastServiceAdapters: [ForecastServiceAdapter]
    private var selectedForecastServiceIndex = 0
    private var forecastService: ForecastService {
        forecastServiceAdapters[selectedForecastServiceIndex]
    }
    
    // MARK: Life Cycle
    init(servicesBuilderType: ForecastServiceListBuilder.Type) {
        self.forecastServiceAdapters = servicesBuilderType.makeForecastServices()
    }
}

// ListDataSource
extension ListLogic: ListDataSource {
    
    var datasourceTitles: [String] {
        forecastServiceAdapters.map { $0.title }
    }
    
    func selectDataSource(index: Int
    ) {
        selectedForecastServiceIndex = index
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
    }
    
    func getSectionsCount(
    ) -> Int {
        dayForecasts.count
    }
    
    func getItemsCount(for section: Int
    ) -> Int {
        guard section < dayForecasts.count else {
            return 0
        }
        return dayForecasts[section].count
    }
    
    func getHeaderTitle(for section: Int
    ) -> String? {
        return section > 0
            ? dayForecasts[section].first?.date
            : nil
    }
    
    func getForecastDisplayData(for indexPath: IndexPath
    ) -> ForecastDisplayData? {
        guard indexPath.section < dayForecasts.count,
            indexPath.row < dayForecasts[indexPath.section].count
            else { return nil }
        
        return dayForecasts[indexPath.section][indexPath.row]
    }
}

// MARK: - ListViewOutput
extension ListLogic: ListViewOutput {
    
    func activate(
    ) {
        view.configure()
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
    }
}

// NARK: - Private Mathods
private extension ListLogic {
    
    func loadData(completion: VoidClosure?
    ) {
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
    
    func handle(successWith forecastResponse: ForecastResponse
    ) {
        guard let forecasts = forecastResponse.items,
            !forecasts.isEmpty
            else { return }
        
        dayForecasts = Forecast5DisplayDataBuilder().make(from: forecasts)
        cityName = forecastResponse.city?.name
        view.update()
    }
    
    func handle(_ error: ApiError
    ) {
        print("!!! \(type(of: self)).\(#function): ERROR: \(error)")
    }
}

private extension String {
    static let defaultCity = "Munich"
}
