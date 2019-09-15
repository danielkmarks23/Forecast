//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Daniel Marks on 06/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit


public let weatherTableViewCell = "WeatherTableViewCell"

public struct WeatherTableViewCellViewModel {
    
    var title: String
    var description: String
    var min: String
    var max: String
    var icon: String
    
    init(title: String, description: String, max: Double, min: Double, icon: String) {
        
        self.title = title
        self.description = description
        self.min = String(Int(min)) + "°"
        self.max = String(Int(max)) + "°"
        self.icon = icon
    }
    
    init(city: City) {
        
        self.title = city.name
        self.description = city.weatherDescription ?? ""
        self.min = String(Int(city.min)) + "°"
        self.max = String(Int(city.max)) + "°"
        self.icon = city.icon ?? ""
    }
    
    init(dailyWeather: DailyWeather) {
        
        self.title = Date(timeIntervalSince1970: dailyWeather.day).toDisplayableString()
        self.description = dailyWeather.weatherDescription ?? ""
        self.min = String(Int(dailyWeather.min)) + "°"
        self.max = String(Int(dailyWeather.max)) + "°"
        self.icon = dailyWeather.icon ?? ""
    }
}

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var forecastImageView: IconImageView!
    
    public func setup(with viewModel: WeatherTableViewCellViewModel) {
        
        nameLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        minLabel.text = viewModel.min
        maxLabel.text = viewModel.max
        
        if viewModel.icon != "" {
            
            forecastImageView.load(path: viewModel.icon)
            forecastImageView.contentMode = .scaleAspectFit
        }
    }
}
