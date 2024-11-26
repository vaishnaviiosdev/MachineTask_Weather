//
//  Model.swift
//  Weather_Task
//
//  Created by Vaishnavi on 23/11/24.
//


import Foundation

struct WeatherResponse: Codable {
    let city: City
    let list: [WeatherListItem]
}

struct City: Codable {
    let name: String
}

struct WeatherListItem: Codable {
    let dt_txt: String  
    let main: MainWeather
    let weather: [weather]
}

struct MainWeather: Codable {
    let temp: Double  
    let feels_like: Double
}

struct weather: Codable {
    let icon: String
    let main: String
    let description: String
}


struct weatherData {
    let city: City
    let list: [WeatherListItem]
}
