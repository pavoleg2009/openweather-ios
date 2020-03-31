//
//  ForecastCell.swift
//  openweather-ios
//
//  Created by Oleg Pavlichenkov on 31.03.2020.
//  Copyright © 2020 just eng. All rights reserved.
//

import UIKit

final class ForecastCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    // MARK: Internal Methods
    func configure(with displayData: ForecastDisplayData
    ) {
        timeLabel.text = displayData.time
        weatherIconImageView.image = displayData.icon
        temperatureLabel.text = displayData.temperature
        selectionStyle = .none
    }
    
    // MARK: Overrides
    override func prepareForReuse(
    ) {
        super.prepareForReuse()
        timeLabel.text = ""
        weatherIconImageView.image = nil
        temperatureLabel.text = ""
    }
}
