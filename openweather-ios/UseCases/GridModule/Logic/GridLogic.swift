//
//  GridLogic.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import Foundation

final class GridLogic {
    
    weak var view: GridViewInput!
    
    // MARK: GridDataSource
    var numberOfItems: Int {
        return displayData.count * (displayData.first?.count ?? 0)
    }
    
    var displayData: [[GridItem]] = {
        var firstRow: [GridItem] = [.emptyCell, .emptyCell] + Array(0...5).map { .fake("0-\($0)") }
        let lastRow: [GridItem] = Array(0...5).map { .fake("5-\($0)") } + [.emptyCell, .emptyCell]
        let fullRows: [[GridItem]] = Array(1...4).map {
            row in
            Array(0...7).map { .fake("\(row)-\($0)") }
        }
        
        return [firstRow]
             + fullRows
             + [lastRow]
    }()
    
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

// NARK: - Private Mathods
private extension GridLogic {
    
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
        // TODO: Generate ne data here
        displayData = Forecast5DisplayDataBuilder().makeGridItems(from: forecasts)
//        cityName = forecastResponse.city?.name
        view.update()
    }
    
    func handle(_ error: ApiError
    ) {
        print("!!! \(type(of: self)).\(#function): ERROR: \(error)")
    }
}

// MARK: - GridViewOutput
extension GridLogic: GridViewOutput {
    
    func activate() {
        view.configure()
        view.showActivityIndicator()
        loadData {
            self.view.hideActivityIndicator()
        }
    }
}

// MARK: - GridDataSource Methods
extension GridLogic: GridDataSource {
    
    func getHeaderTitle(for section: Int) -> String? {
        return section == 0 ? "раз-раз" : "два-два"
    }
    
}

private extension String {
    static let defaultCity = "Munich"
}
