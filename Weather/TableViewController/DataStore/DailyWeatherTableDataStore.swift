//
//  DailyWeatherDataStore.swift
//  Weather
//
//  Created by Daniel Marks on 07/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class DailyWeatherTableDataStore: TableDataStoring {
    
    var array: [Codable]
    let manager: WeatherManager
    
    init(manager: WeatherManager) {
        
        self.manager = manager
        self.array = []
    }
    
    func load(arg: String?, completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        manager.loadDailyWeather(name: arg!, completion: { dailyWeatherArray in
            
            self.array = dailyWeatherArray
            completion(dailyWeatherArray)
        }, catchError: errorHandling)
    }
}

