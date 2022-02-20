//
//  KelvinToCelsiusConverter.swift
//  CuteWeather
//
//  Created by Filipe Nunes on 19/02/22.
//

import UIKit

extension Float {
    func truncate(places : Int)-> Float
    {
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
    
    func kelvinToCeliusConverter() -> Float {
        let constantVal : Float = 273.15
        let kelValue = self
        let celValue = kelValue - constantVal
        return celValue.truncate(places: 1)
    }
}

