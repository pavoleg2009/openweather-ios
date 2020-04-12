//
//  Forecast5ViewController.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 29.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    typealias Presenter = ListViewOutput & ListDataSource
    
    var presenter: Presenter!
    
    // MARK: Outlets
    @IBOutlet private weak var sourcesSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self

            tableView.owa_register(RegularForecastListCell.self)
            tableView.owa_register(TodayForecastListCell.self)
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad(
    ) {
        super.viewDidLoad()
        navigationItem.title = .title
    }
    
    // MARK: Actions
    @IBAction private func sourceIndexDidChange(_ sender: Any
    ) {
        presenter.selectDataSource(index: sourcesSegmentedControl.selectedSegmentIndex)
    }
}

// MARK: - ListViewInput
extension ListViewController: ListViewInput {
    
    func configure(
    ) {
        // We need to load view before we can configure it
        // This method is called from logic while VC not in the view hierarchy yet
        loadViewIfNeeded()
        configureSegmentedControl()
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
            self.navigationItem.title = self.presenter.cityName ?? .title
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource {
extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.getHeaderTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getItemsCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let (itemType, itemData) = presenter.getForecastDisplayData(for: indexPath)
            else {
                fatalError("Can not retrieve displayData for indexPath: \(indexPath)")
        }

        switch itemType {
        case .today:
            let cell: TodayForecastListCell = tableView.owa_dequeueReusableCell(for: indexPath)
            cell.configure(with: itemData)
            return cell
        case .regular:
            let cell: RegularForecastListCell = tableView.owa_dequeueReusableCell(for: indexPath)
            cell.configure(with: itemData)
            return cell
        }
    }
}

// MARK: UITableViewDelegate {
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == .todayCellIndexPath {
            return view.bounds.width * .todayCellAspectRatio
        } else {
            return .forecastCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == .todayCellIndexPath {
            return view.bounds.width * .todayCellAspectRatio
        } else {
            return .forecastCellHeight
        }
    }
}
// MARK: - Private Methods
private extension ListViewController {
    
    func configureSegmentedControl() {
        
        sourcesSegmentedControl.removeAllSegments()
        
        guard !presenter.datasourceTitles.isEmpty else { return }
        
        for (index, title) in presenter.datasourceTitles.enumerated() {
            sourcesSegmentedControl.insertSegment(withTitle: title,
                                                  at: index,
                                                  animated: false)
        }
        sourcesSegmentedControl.selectedSegmentIndex = 0
    }
    
}

private extension String {
    static let title = "Forecast"
}

private extension IndexPath {
    static let todayCellIndexPath = IndexPath(row: 0, section: 0)
}

private extension CGFloat {
    static let todayCellAspectRatio: CGFloat = 0.75
    static let forecastCellHeight: CGFloat = 66
}
