//
//  Forecast5ViewController.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class Forecast5ViewController: UIViewController {
    
    typealias Logic = Forecast5ViewOutput & Forecast5DataSource
    
    var logic: Logic!
    
    // MARK: Outlets
    @IBOutlet private weak var sourcesSegmetedConrol: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            let forecastNib = UINib(nibName: .forecastCellItentifier, bundle: nil)
            tableView.register(forecastNib, forCellReuseIdentifier: .forecastCellItentifier)
            let todayNib = UINib(nibName: .todayCellItentifier, bundle: nil)
            tableView.register(todayNib, forCellReuseIdentifier: .todayCellItentifier)
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad(
    ) {
        super.viewDidLoad()
        title = .title
    }
    
    // MARK: Actions
    @IBAction private func sourceIndexDidChange(_ sender: Any
    ) {
        logic.selectDataSource(index: sourcesSegmetedConrol.selectedSegmentIndex)
    }
}

// MARK: - Forecast5ViewInput
extension Forecast5ViewController: Forecast5ViewInput {
    
    func configure(
    ) {
        // We need to load view before we can configure it
        // This method is called from logic while VC not in the view hierarche yet
        loadViewIfNeeded()
        configureSegmentedContol()
        print("!!! \(type(of: self)).\(#function): ")
    }
    
    func showActivityIndicator() {
        print("!!! \(type(of: self)).\(#function): Show activity indicator here")
    }
    
    func hideActivityIndicator() {
        print("!!! \(type(of: self)).\(#function): Hide activity indicator here")
    }
    
    func showError(errorDescription: String) {
        print("!!! \(type(of: self)).\(#function): Error: \(errorDescription)")
    }
     
    func update() {
        DispatchQueue.main.async {
            self.title = self.logic.cityName ?? .title
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource {
extension Forecast5ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return logic.getSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return logic.getHeaderTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logic.getItemsCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let displayData = logic.getForecastDisplayData(for: indexPath)
        else { fatalError("Can not retrive displayDaya for indexPath: \(indexPath)") }
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            // TODAY:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .todayCellItentifier, for: indexPath) as? TodayCell
            else { fatalError("Can not dequeue cell with identifier: \(String.forecastCellItentifier)") }
            cell.configure(with: displayData)
            return cell
        case (0, 1...), (1..., _):
            // Regular cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .forecastCellItentifier, for: indexPath) as? ForecastCell
            else { fatalError("Can not dequeue cell with identifier: \(String.forecastCellItentifier)") }
            cell.configure(with: displayData)
            return cell
        default:
            fatalError("No Cell type for indexPath: \(indexPath)")
        }
    }
    
}

// MARK: UITableViewDelegate {
extension Forecast5ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == .todayCellIndexPath {
            return view.bounds.width * .todayCellAspectRatio
        } else {
            return UITableView.automaticDimension
        }
    }
}
// MARK: - Private Methods
private extension Forecast5ViewController {
    
    func configureSegmentedContol() {
        
        sourcesSegmetedConrol.removeAllSegments()
        
        guard !logic.datasourceTitles.isEmpty else { return }
        
        for (index, title) in logic.datasourceTitles.enumerated() {
            sourcesSegmetedConrol.insertSegment(withTitle: title,
                                                at: index,
                                                animated: false)
        }
        sourcesSegmetedConrol.selectedSegmentIndex = 0
    }
    
}

private extension String {
    static let todayCellItentifier = "TodayCell"
    static let forecastCellItentifier = "ForecastCell"
    static let title = "Forecast"
}

private extension IndexPath {
    static let todayCellIndexPath = IndexPath(row: 0, section: 0)
}

private extension CGFloat {
    static let todayCellAspectRatio: CGFloat = 0.75
}
