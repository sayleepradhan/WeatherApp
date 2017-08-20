//
//  ForecastService.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/19/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastService
{
    let forecastAPIKey: String
    let forecastBaseURL: URL?
    let locationManager: CLLocationManager?
    init(APIKey: String)
    {
        self.forecastAPIKey = APIKey
        forecastBaseURL = URL(string: "http://api.wunderground.com/api/\(APIKey)")
        locationManager = CLLocationManager()
        
    }
    
    func getForecast(state: String, city: String, completion: @escaping (CurrentWeather?) -> Void)
    {
        if let forecastURL = URL(string: "\(forecastBaseURL!)/conditions/q/\(state)/\(city).json") {
            
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
                
                if let currentWeatherDictionary = jsonDictionary?["current_observation"] as? [String : Any] {
                    let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currentWeather)
                } else {
                    completion(nil)
                }
                
            })
            
        }
    }
}
