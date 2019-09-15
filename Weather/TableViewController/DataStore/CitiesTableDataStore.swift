//
//  CitiesTableDataStore.swift
//  Weather
//
//  Created by Daniel Marks on 07/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class CitiesTableDataStore: TableDataStoring {
    
    var array: [Codable]
    let manager: WeatherManager
    
    init(manager: WeatherManager) {
        
        self.manager = manager
        self.array = []
    }
    
    func load(arg: String?, completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        manager.loadCities(completion: { cities in
            
            self.array = cities
            completion(cities)
        }, catchError: errorHandling)
    }
}
