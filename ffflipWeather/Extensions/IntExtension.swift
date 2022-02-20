//
//  IntExtension.swift
//  CuteWeather
//
//  Created by Filipe Nunes on 19/02/22.
//

import UIKit

extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}

