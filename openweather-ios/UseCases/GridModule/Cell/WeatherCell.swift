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
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    
    // TODO: replace with display data
    func configure(temp: String, icon: UIImage?) {
        weatherIconImageView.image = icon
        temperatureLabel.text = temp
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weatherIconImageView.image = nil
        temperatureLabel.text = nil
    }
}

extension WeatherCell: ReuseableView {}
