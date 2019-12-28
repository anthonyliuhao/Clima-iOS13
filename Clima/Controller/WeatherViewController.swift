//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var wm = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the WeatherViewController instance as a delegate of the CLLocationManager instance
        locationManager.delegate = self
        
        // Ask for user permission to access location
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() // Request one-time location
        
        // searchTextField should set the WeatherViewController instance as its delegate
        searchTextField.delegate = self
        
        // WeatherManager sets the WeatherViewController instance as its delegate
        wm.delegate = self
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
        @IBAction func searchButtonPressed(_ sender: UIButton) {
    //        print(searchTextField.text!)
            
            // Make the keyboard go away
            searchTextField.endEditing(true)
        }
    
    // This function triggers when user taps on the return button
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        print(searchTextField.text!)
            
            // Make the keyboard go away
            searchTextField.endEditing(true)
            
            // Return true means the view controller allows the text field to return
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            // this code triggers when any text field finishes editing
            
            if let city = searchTextField.text {
                wm.fetchWeather(city: city)
            }
            searchTextField.text = ""
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            // This is a good place for validation
            // Traps user in the text field if they haven't typed anything, for example
            
            // textField is whatever field triggers this function
            if textField.text != "" {
                
                // The user is allowed to end editing
                return true
            }
            else {
                textField.placeholder = "Please type a location"
                return false
            }
        }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.cityName)
        print(weather.conditionID)
        print(weather.conditionName)
        print(weather.tempString)
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = locations.last {
            // As soon as a location is found, we tell the Location Manager to stop
            locationManager.stopUpdatingLocation()
            print("Got location!")
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            wm.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}
