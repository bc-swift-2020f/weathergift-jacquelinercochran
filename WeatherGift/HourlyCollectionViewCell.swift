//
//  HourlyCollectionViewCell.swift
//  WeatherGift
//
//  Created by Jackie Cochran on 10/22/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourlyImageView: UIImageView!
    @IBOutlet weak var hourlyTemperature: UILabel!
    
    var hourlyWeather: HourlyWeather! {
        didSet{
            hourLabel.text = hourlyWeather.hour
            hourlyImageView.image = UIImage(systemName: hourlyWeather.hourlyIcon) //TODO: add icons later
            hourlyTemperature.text = "\(hourlyWeather.hourlyTemperature)"
        }
    }
}
