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
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title
    }
    
    @IBAction private func sourceIndexDidChange(_ sender: Any) {
        logic.selectDataSource(index: sourcesSegmetedConrol.selectedSegmentIndex)
    }
}

// MARK: - Forecast5ViewInput
extension Forecast5ViewController: Forecast5ViewInput {
    
    func configure() {
        // We need to load view before we can configure it
        // This method is called from logic while VC not in the view hierarche yet
        loadViewIfNeeded()
        configureSegmentedContol()
        print("!!! \(type(of: self)).\(#function): ")
    }
    
    func showActivityIndicator() {
//        print("!!! \(type(of: self)).\(#function): Show activity indicator here")
    }
    
    func hideActivityIndicator() {
//        print("!!! \(type(of: self)).\(#function): Hide activity indicator here")
    }
    
    func showError(errorDescription: String) {
//        print("!!! \(type(of: self)).\(#function): Error: \(errorDescription)")
    }
     
    func update() {
        DispatchQueue.main.async {
            self.title = self.logic.cityName ?? .title
//            self.tableView.reloadData()
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
    static let title = "Forecast"
}
