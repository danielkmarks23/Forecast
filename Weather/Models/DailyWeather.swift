//
//  DailyWeather.swift
//  Weather
//
//  Created by Daniel Marks on 07/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

struct DailyWeatherResponse: Codable {
    
    var dailyWeatherArray: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        
        case dailyWeatherArray = "list"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dailyWeatherArray = try container.decode([DailyWeather].self, forKey: .dailyWeatherArray)
    }
}

struct DailyWeather: Codable {
    
    var day: Double
    var weatherDescription: String?
    var min: Double
    var max: Double
    var icon: String?
    
    enum CodingKeys: String, CodingKey {
        
        case weatherDescription = "main"
        case min = "temp_min"
        case max = "temp_max"
        case icon
    }
    
    enum ObjectKeys: String, CodingKey {
        
        case day = "dt"
        case main
        case weather
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ObjectKeys.self)
        self.day = try container.decode(Double.self, forKey: .day)
        
        let main = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        self.min = try main.decode(Double.self, forKey: .min)
        self.max = try main.decode(Double.self, forKey: .max)
        
        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)
        
        while(!weatherArray.isAtEnd) {
            
            let weather = try weatherArray.decode(Weather.self)
            self.weatherDescription = weather.weatherDescription
            self.icon = weather.icon
        }
    }
}
