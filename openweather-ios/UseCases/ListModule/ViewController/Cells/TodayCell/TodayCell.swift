//
//  TodayCell.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 31.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

class TodayCell: UITableViewCell, ReusableView {
    
    // MARK: Outlets
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    
    // MARK: Internal Methods
    func configure(with displayData: ForecastDisplayData
    ) {
        descriptionLabel.text = displayData.description
        temperatureLabel.text = displayData.temperature
        feelsLikeLabel.text = displayData.feelsLike
        weatherIconImageView.image = displayData.icon
        selectionStyle = .none
    }
    
    // MARK: Overrides        
    override func prepareForReuse(
    ) {
        super.prepareForReuse()
        
        descriptionLabel.text = ""
        temperatureLabel.text = ""
        feelsLikeLabel.text = ""
        weatherIconImageView.image = nil
    }
}
