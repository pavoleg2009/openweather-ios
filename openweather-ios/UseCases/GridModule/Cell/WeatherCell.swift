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
        contentView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weatherIconImageView.image = nil
        temperatureLabel.text = nil
    }
}

extension WeatherCell: ReuseableView {}
