//
//  WeatherManager.swift
//  Clima
//
//  Created by Anthony Liu on 2019/12/26.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=6ecb18f0ba16450d49a29d7ea5ccbc44&&units=metric"
    
    func fetchWeather(city: String) {
        let urlString = "\(weatherUrl)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // Step 1 Create a URL
        if let url = URL(string: urlString) {
            // Step 2 Create a URL session
            let session = URLSession(configuration: .default)
            
            // Step 3 Give the session a task
            // CompletionHandler is the equivalent of a call back
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    self.parseJSON(data: safeData)
                    
                }
            }
            
            // Step 4 Start the task
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(conditionID: id, cityName: cityName, temp: temp)
            print(weather.tempString)
            
        } catch {
            print(error)
        }
    }
    
    
    
}
