//
//  GridViewController.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class GridViewController: UIViewController {

    var logic: GridViewOutput!
    
    // MARK: Outlets
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            print("!!! RI: \(WeatherCell.reuseIdentifier) ")
            let weatherNib = UINib(nibName: WeatherCell.reuseIdentifier, bundle: nil)
//            collectionView.register(WeatherCell.reuseIdentifier, forCellWithReuseIdentifier: )
        }
    }
        
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "COLLECTION!"
    }
}

// MARK: - GridViewInput
extension GridViewController: GridViewInput {
    func configure() {
        print("!!! \(type(of: self)).\(#function): ")
    }
}
