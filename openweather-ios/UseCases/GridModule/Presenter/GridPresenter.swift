//
//  GridPresenter.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class GridPresenter {
    
    weak var view: GridViewInput!
    
    // MARK: Private Properties
    private var forecastServiceAdapters: [ForecastServiceAdapter]
    private var selectedForecastServiceIndex = 0
    private var forecastService: ForecastService {
        forecastServiceAdapters[selectedForecastServiceIndex]
    }
    private var displayData: [[GridItem]] = []
    
    // MARK: Life Cycle
    init(servicesBuilderType: ForecastServiceListBuilder.Type) {
        self.forecastServiceAdapters = servicesBuilderType.makeForecastServices()
    }
}

// MARK: - Private Methods
private extension GridPresenter {
    
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
        completion?()
    }
    
    func handle(successWith forecastResponse: ForecastResponse
    ) {
        guard let forecasts = forecastResponse.items,
            !forecasts.isEmpty
            else { return }
    
        displayData = Forecast5DisplayDataBuilder().makeGridItems(from: forecasts)
        
        DispatchQueue.main.async {
            self.view.update()
        }
    }
    
    func handle(_ error: ApiError
    ) {
        print("!!! \(type(of: self)).\(#function): ERROR: \(error)")
    }
}

// MARK: - GridViewOutput
extension GridPresenter: GridViewOutput {
    
    func activate() {
        view.configure()
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
    }
}

// MARK: - GridDataSource Methods
extension GridPresenter: GridDataSource {
    
    var datasourceTitles: [String] {
        forecastServiceAdapters.map { $0.title }
    }
    
    var colCount: Int {
        return 8 // 24 hours/day / 3 hours/forecastItem = 8 forecastItem/day
    }
    
    var rowCount: Int {
        displayData.count
    }
    
    func selectDataSource(index: Int) {
        selectedForecastServiceIndex = index
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
    }
    
    func getItemsCount(for section: Int) -> Int {
        return displayData.count * (displayData.first?.count ?? 0)
    }
    
    func getGridItem(for indexPath: IndexPath) -> GridItem? {

        let row = indexPath.item % rowCount
        let col = indexPath.item / rowCount
        
        guard row < displayData.count,
            col < displayData[row].count
            else { return nil }
        
        return displayData[row][col]
    }
    
}

private extension String {
    static let defaultCity = "Munich"
}
