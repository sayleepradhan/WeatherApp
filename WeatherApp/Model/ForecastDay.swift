//
//  ForecastDay.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/21/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import Foundation

class ForecastDay {
    
    let date: String?
    let lowTemp: String?
    let highTemp: String?
    let conditions: String?
    let humidity: String?
    let iconURL: String?
    let city: String?
    let wind: String?
    let precipitation: String?
    
    struct WeatherKeys {
        static let highTemp = "high"
        static let lowTemp = "low"
        static let fahrenheit = "fahrenheit"
        static let conditions = "conditions"
        static let humidity = "avehumidity"
        static let precipitation = "qpf_allday"
        static let precipitation_in = "in"
        static let wind = "avewind"
        static let wind_mph = "mph"
        static let wind_dir = "dir"
        static let iconURL = "icon_url"
        static let city = "city"
        static let date = "date"
    }
    
    init(weatherDictionary: [String : Any], cityName: String)
    {
        date = Utility.getDateFromJson(dateInfo: weatherDictionary[WeatherKeys.date] as! [String : Any])
        if let highTempDictionary = weatherDictionary[WeatherKeys.highTemp] as? [String:Any] {
            highTemp = highTempDictionary[WeatherKeys.fahrenheit] as? String
            if highTemp != nil {
                highTemp!.append(" F")
            }
        } else {
            highTemp = "-"
        }
        if let lowTempDictionary = weatherDictionary[WeatherKeys.lowTemp] as? [String:Any] {
            lowTemp = lowTempDictionary[WeatherKeys.fahrenheit] as? String
            if lowTemp != nil {
                lowTemp!.append(" F")
            }
        } else {
            lowTemp = "-"
        }
        conditions = weatherDictionary[WeatherKeys.conditions] as? String ?? "-"
        if let humidityValue = weatherDictionary[WeatherKeys.humidity] as? Int {
            humidity = String(format: "\(humidityValue)%%")
        } else {
            humidity = nil
        }
        iconURL = weatherDictionary[WeatherKeys.iconURL] as? String ?? nil
        city = cityName
        if let windInfo = weatherDictionary[WeatherKeys.wind] as? [String: Any] {
            if let direction = windInfo[WeatherKeys.wind_dir] as? String, let mph = windInfo[WeatherKeys.wind_mph] as? Int {
                    wind = String(format: "Wind: From the \(direction) at \(mph) MPH")
            } else {
                wind = "-"
            }
        } else {
                wind = "-"
        }
        if let prec = weatherDictionary[WeatherKeys.precipitation] as? [String: Any], let prec_in = prec[WeatherKeys.precipitation_in] as? Int {
            precipitation = String(format: "\(prec_in) in")
        } else {
            precipitation = nil
        }
    }
}
