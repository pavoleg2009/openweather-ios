//
//  WeatherCell.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 07.04.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class WeatherCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var dateLabel: UILabel!
    
    // TODO: replace with display data
    func configure(text: String) {
        dateLabel.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension WeatherCell: ReuseableView {}
