//
//  ViewController.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/19/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayTimeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    let forecastService = ForecastService(APIKey: "bf446a4d96bb2f95")
    
    override func viewWillAppear(_ animated: Bool) {
       self.dayTimeLabel.text = Utility.getDayTime()
       pause()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                forecastService.locationManager?.requestWhenInUseAuthorization()
            }
            forecastService.locationManager?.startUpdatingLocation()
            self.getWeatherUpdate()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getWeatherUpdate() {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation((forecastService.locationManager?.location)!, completionHandler: {
            (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary as Any)
            
            if let city = placeMark.addressDictionary!["City"] as? NSString, let state = placeMark.addressDictionary!["State"] as? NSString {
                let cityName = city.replacingOccurrences(of: " ", with: "_")
                
                self.forecastService.getCurrentWeather(state: state as String, city: cityName as String) { (currentWeather) in
                    // OFF THE MAIN QUEUE!!!!
                    if let currentWeather = currentWeather {
                        // RULE: ALL UI CODE MUST HAPPEN ON THE MAIN QUEUE
                        // TODO: get back to the main queue
                        DispatchQueue.main.async {
                            self.restore()
                            if let tempInF = Utility.getTempInF(temp: currentWeather.temperature!){
                                
                                self.temperatureLabel.text = "\(tempInF)"
                                
                            } else {
                                self.temperatureLabel.text = "-"
                            }
                            
                            if let weather = currentWeather.weather {
                                self.weatherLabel.text = "\(weather)"
                            } else {
                                self.weatherLabel.text = "-"
                            }
                            
                            if let iconURL = currentWeather.iconURL {
                                if let imageData = Utility.getImage(url: iconURL) {
                                    self.iconImageView.image = UIImage(data: imageData)
                                }
                            }
                            if let humidity = currentWeather.humidity {
                                self.humidityLabel.text = humidity
                            } else {
                                self.humidityLabel.text = "-"
                            }
                            
                            if let tempInF = Utility.getTempInF(temp: currentWeather.feels_like!){
                                
                                self.feelsLikeLabel.text = "\(tempInF)"
                                
                            } else {
                                self.feelsLikeLabel.text = "-"
                            }
                            
                            if let visibility = currentWeather.visibility {
                                self.visibilityLabel.text = "\(visibility) mi"
                            } else {
                                self.visibilityLabel.text = "-"
                            }
                            
                            if let wind = currentWeather.wind {
                                self.windLabel.text = wind
                            } else {
                                self.windLabel.text = "-"
                            }
                            
                            if let precipitation = currentWeather.precipitation {
                                self.precipitationLabel.text = precipitation
                            } else {
                                self.precipitationLabel.text = "-"
                            }
                            
                            self.cityLabel.text = city as String
                        }
                        
                        
                    }
                }
            }
            
        })
        
    }
    
    func pause() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func restore() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}

