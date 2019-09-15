//
//  City.swift
//  Weather
//
//  Created by Daniel Marks on 06/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

struct CitiesResponse: Codable {
    
    var cities: [City]
    
    enum CodingKeys: String, CodingKey {
        
        case cities = "list"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cities = try container.decode([City].self, forKey: .cities)
    }
}

struct City: Codable {
    
    var name: String
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
        
        case name
        case main
        case weather
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: ObjectKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
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

struct Weather: Codable {
    
    var weatherDescription: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        
        case weatherDescription = "main"
        case icon
    }
}
