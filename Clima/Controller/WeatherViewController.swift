//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // searchTextField should set the WeatherViewController instance as its delegate
        searchTextField.delegate = self
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        
        // Make the keyboard go away
        searchTextField.endEditing(true)
    }
    
    // This function triggers when user taps on the return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        
        // Make the keyboard go away
        searchTextField.endEditing(true)
        
        // Return true means the view controller allows the text field to return
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // this code triggers when any text field finishes editing
        
        
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

