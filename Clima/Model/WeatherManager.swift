//
//  WeatherManager.swift
//  Clima
//
//  Created by Anthony Liu on 2019/12/26.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
    // Error handler that lets the delegate handles any error
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=6ecb18f0ba16450d49a29d7ea5ccbc44&&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
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
            // Use a closure to handle the call back
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather: WeatherModel = self.parseJSON(data: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // Step 4 Start the task
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(conditionID: id, cityName: cityName, temp: temp)
            return weather
            
        } catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

