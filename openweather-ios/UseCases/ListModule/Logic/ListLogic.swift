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
    
    // MARK: Forecast5DataSource
    private var dayForecasts: [DayForecastDiaplayData] = []
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
extension ListLogic: Forecast5DataSource {
    
    var datasourceTitles: [String] {
        forecastServiceAdapters.map { $0.title }
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
        return dayForecasts[section].forecastItems.count
    }
    
    func getHeaderTitle(for section: Int
    ) -> String? {
        return section > 0
            ? dayForecasts[section].forecastItems.first?.date
            : nil
    }
    
    func getForecastDisplayData(for indexPath: IndexPath
    ) -> ForecastDisplayData? {
        guard indexPath.section < dayForecasts.count,
            indexPath.row < dayForecasts[indexPath.section].forecastItems.count
            else { return nil }
        
        return dayForecasts[indexPath.section].forecastItems[indexPath.row]
    }
    
    func selectDataSource(index: Int
    ) {
        selectedDatasourceIndex = index
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
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
