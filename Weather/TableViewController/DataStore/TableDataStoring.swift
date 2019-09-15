//
//  TableDataStoring.swift
//  Weather
//
//  Created by Daniel Marks on 07/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

protocol TableDataStoring {
    
    var array: [Codable] { get }
    
    func load(arg: String?, completion: @escaping (([Codable]) -> Void), catchError errorHandling: @escaping (Error) -> Void)
}
