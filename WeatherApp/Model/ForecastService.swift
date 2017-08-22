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
    
    func getCurrentWeather(state: String, city: String, completion: @escaping (CurrentWeather?) -> Void)
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
    
    func getTenDayForecast(state: String, city: String, completion: @escaping([ForecastDay]?) -> Void){
        if let forecastURL = URL(string: "\(forecastBaseURL!)/forecast10day/q/\(state)/\(city).json") {
            let networkProcessor = NetworkProcessor(url: forecastURL)
            networkProcessor.downloadJSONFromURL({ (jsonDictionary) in
                
                var forecastInfo = [ForecastDay]()
                if let forecastDictionary = jsonDictionary?["forecast"] as? [String : Any] {
                    if let simpleForecast = forecastDictionary["simpleforecast"] as? [String : Any] {
                        if let forecastPeriodWise = simpleForecast["forecastday"] as? [Any] {
                            for period in forecastPeriodWise {
                                if let currentPeriod = period as? [String: Any] {
                                    let forecastItem = ForecastDay(weatherDictionary: currentPeriod, cityName: city)
                                    forecastInfo.append(forecastItem)
                                }
                            }
                        }
                    }
                    completion(forecastInfo)
                } else {
                    completion(nil)
                }
            })
        }
    
    }
}
