//
//  WeatherManager.swift
//  Weather
//
//  Created by Daniel Marks on 07/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

class WeatherManager {
    
    private var baseURL = "https://api.openweathermap.org/data/2.5"
    var webService = WebService()
    
    func loadCities(completion: @escaping (([City]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        let units = (UIApplication.shared.delegate as! AppDelegate).currentUnits
        let url = baseURL + "/group?id=281184,2643743,6455259,4164138,1850147&units=\(units)&APPID=\(webService.apiKey)"
        webService.load(url: url, completion: { (result: CitiesResponse) in
            
            completion(result.cities)
        }, catchError: errorHandling)
    }
    
    func loadDailyWeather(name: String, completion: @escaping (([DailyWeather]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        let units = (UIApplication.shared.delegate as! AppDelegate).currentUnits
        let url = baseURL + "/forecast?q=\(name)&units=\(units)&APPID=\(webService.apiKey)"
        webService.load(url: url, completion: { (result: DailyWeatherResponse) in
            
            completion(result.dailyWeatherArray)
        }, catchError: errorHandling)
    }
}
