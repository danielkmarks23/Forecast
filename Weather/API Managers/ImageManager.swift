//
//  ImageManager.swift
//  Weather
//
//  Created by Daniel Marks on 06/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

class ImageManager {
    
    private var baseURL = "https://openweathermap.org/img/w/"
    var webService = WebService()
    
    func loadImage(imagePath: String, completion: @escaping ((Data) -> Void), catchError errorHandling: @escaping (Error) -> Void) {
        
        let url = baseURL + imagePath + ".png"
        
        webService.loadData(url: url, completion: completion, catchError: errorHandling)
    }
}
