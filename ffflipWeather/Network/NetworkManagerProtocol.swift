//
//  NetworkManagerProtocol.swift
//  CuteWeather
//
//  Created by Filipe Nunes on 19/02/22.
//

import UIKit

protocol NetworkManagerProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherModel) -> ())
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ())
    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ())
}

