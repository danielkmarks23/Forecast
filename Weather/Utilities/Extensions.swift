//
//  Extensions.swift
//  Weather
//
//  Created by Daniel Marks on 07/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import Foundation

extension Date {
    
    func toDisplayableString() -> String {
        
        if Calendar.current.isDateInToday(self) {
            return "Today"
        }
        
        if Calendar.current.isDateInTomorrow(self) {
            return "Tomorrow"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
