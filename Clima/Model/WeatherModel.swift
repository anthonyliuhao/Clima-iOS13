//
//  WeatherModel.swift
//  Clima
//
//  Created by Anthony Liu on 2019/12/26.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temp: Double
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    // Computed property
    var conditionName: String {
        return getConditionName(weatherID: self.conditionID)
    }
    
    func getConditionName(weatherID: Int) -> String {
        switch weatherID {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...809:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
