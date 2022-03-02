//
//  Forecast.swift
//  CuteWeather
//
//  Created by Filipe Nunes on 19/02/22.
//

import UIKit

struct ForecastTemperature {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
    let tempEmoji: UILabel?
}

struct WeatherInfo {
    let temp: Float
    let min_temp: Float
    let max_temp: Float
    let description: String
    let icon: String
    let time: String
}


