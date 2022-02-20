//
//  DateExtension.swift
//  CuteWeather
//
//  Created by Filipe Nunes on 19/02/22.
//

import UIKit

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}

