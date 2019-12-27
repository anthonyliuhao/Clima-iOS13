//
//  WeatherData.swift
//  Clima
//
//  Created by Anthony Liu on 2019/12/26.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

// Using the Codable type alias (=Encodable + Decodable)
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
