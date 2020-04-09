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
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    
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
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFonts(with: contentView.frame.height)
    }
    
    private func updateFonts(with cellHeight: CGFloat) {
        let dateFontSize: CGFloat = ceil(contentView.frame.height / .dateFontScale)
        let tempFontSize: CGFloat = ceil(contentView.frame.height / .tempFontScale)
        dateLabel.font = UIFont.systemFont(ofSize: dateFontSize)
        temperatureLabel.font = UIFont.systemFont(ofSize: tempFontSize)
    }
}

extension WeatherCell: ReuseableView {}

private extension CGFloat {
    static let dateFontScale: CGFloat = 10.0
    static let tempFontScale: CGFloat = 8.0
}
