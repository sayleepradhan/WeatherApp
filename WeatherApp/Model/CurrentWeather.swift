//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/19/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import Foundation

class CurrentWeather
{
    let temperature: String?
    let humidity: String?
    let weather: String?
    let feels_like: String?
    let iconURL: String?
    let city: String?
    let wind: String?
    let visibility: String?
    let precipitation: String?
    
    struct WeatherKeys {
        static let temperature = "temperature_string"
        static let feels_like = "feelslike_string"
        static let humidity = "relative_humidity"
        static let weather = "weather"
        static let iconURL = "icon_url"
        static let location = "display_location"
        static let city = "city"
        static let wind = "wind_string"
        static let visibility = "visibility_mi"
        static let precipitation = "precip_today_string"
        
    }
    
    init(weatherDictionary: [String : Any])
    {
        temperature = weatherDictionary[WeatherKeys.temperature] as? String
        
        if let humidityStr = weatherDictionary[WeatherKeys.humidity] as? String {
            humidity = humidityStr
        } else {
            humidity = nil
        }
        
        if let feelsLikeTemp = weatherDictionary[WeatherKeys.feels_like] as? String {
            feels_like = feelsLikeTemp
        } else {
            feels_like = nil
        }
        
        if let weatherDesc = weatherDictionary[WeatherKeys.weather] as? String {
            weather = weatherDesc
        } else {
            weather = nil
        }
        
        if let iconURLString = weatherDictionary[WeatherKeys.iconURL] as? String {
            iconURL = iconURLString
        } else {
            iconURL =  nil
        }
        if let locationDtl = weatherDictionary[WeatherKeys.location] as? [String: Any] {
            if let cityName = locationDtl[WeatherKeys.city] as? String {
                city = cityName
            } else {
                city = nil
            }
        } else {
            city = nil
        }
        
        if let windInfo = weatherDictionary[WeatherKeys.wind] as? String {
            wind = windInfo
        } else {
            wind = nil
        }
        visibility = weatherDictionary[WeatherKeys.visibility] as? String ?? nil
        precipitation = weatherDictionary[WeatherKeys.precipitation] as? String ?? nil
        
    }
    
    /*
     {
     "response": {
     "version": "0.1",
     "termsofService": "http://www.wunderground.com/weather/api/d/terms.html",
     "features": {
     "conditions": 1
     }
     },
     "current_observation": {
     "image": {
     "url": "http://icons-ak.wxug.com/graphics/wu2/logo_130x80.png",
     "title": "Weather Underground",
     "link": "http://www.wunderground.com"
     },
     "display_location": {
     "full": "San Francisco, CA",
     "city": "San Francisco",
     "state": "CA",
     "state_name": "California",
     "country": "US",
     "country_iso3166": "US",
     "zip": "94101",
     "latitude": "37.77500916",
     "longitude": "-122.41825867",
     "elevation": "47.00000000"
     },
     "observation_location": {
     "full": "SOMA - Near Van Ness, San Francisco, California",
     "city": "SOMA - Near Van Ness, San Francisco",
     "state": "California",
     "country": "US",
     "country_iso3166": "US",
     "latitude": "37.773285",
     "longitude": "-122.417725",
     "elevation": "49 ft"
     },
     "estimated": {},
     "station_id": "KCASANFR58",
     "observation_time": "Last Updated on June 27, 5:27 PM PDT",
     "observation_time_rfc822": "Wed, 27 Jun 2012 17:27:13 -0700",
     "observation_epoch": "1340843233",
     "local_time_rfc822": "Wed, 27 Jun 2012 17:27:14 -0700",
     "local_epoch": "1340843234",
     "local_tz_short": "PDT",
     "local_tz_long": "America/Los_Angeles",
     "local_tz_offset": "-0700",
     "weather": "Partly Cloudy",
     "temperature_string": "66.3 F (19.1 C)",
     "temp_f": 66.3,
     "temp_c": 19.1,
     "relative_humidity": "65%",
     "wind_string": "From the NNW at 22.0 MPH Gusting to 28.0 MPH",
     "wind_dir": "NNW",
     "wind_degrees": 346,
     "wind_mph": 22.0,
     "wind_gust_mph": "28.0",
     "wind_kph": 35.4,
     "wind_gust_kph": "45.1",
     "pressure_mb": "1013",
     "pressure_in": "29.93",
     "pressure_trend": "+",
     "dewpoint_string": "54 F (12 C)",
     "dewpoint_f": 54,
     "dewpoint_c": 12,
     "heat_index_string": "NA",
     "heat_index_f": "NA",
     "heat_index_c": "NA",
     "windchill_string": "NA",
     "windchill_f": "NA",
     "windchill_c": "NA",
     "feelslike_string": "66.3 F (19.1 C)",
     "feelslike_f": "66.3",
     "feelslike_c": "19.1",
     "visibility_mi": "10.0",
     "visibility_km": "16.1",
     "solarradiation": "",
     "UV": "5",
     "precip_1hr_string": "0.00 in ( 0 mm)",
     "precip_1hr_in": "0.00",
     "precip_1hr_metric": " 0",
     "precip_today_string": "0.00 in (0 mm)",
     "precip_today_in": "0.00",
     "precip_today_metric": "0",
     "icon": "partlycloudy",
     "icon_url": "http://icons-ak.wxug.com/i/c/k/partlycloudy.gif",
     "forecast_url": "http://www.wunderground.com/US/CA/San_Francisco.html",
     "history_url": "http://www.wunderground.com/history/airport/KCASANFR58/2012/6/27/DailyHistory.html",
     "ob_url": "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=37.773285,-122.417725"
     }
     }
     
     */
}
