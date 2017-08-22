//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/20/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: BaseViewController {

    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    let forecastService = ForecastService(APIKey: "bf446a4d96bb2f95")
    var foreCastData = [ForecastDay]()
    
    override func viewWillAppear(_ animated: Bool) {
            self.getWeatherUpdate()
            pause()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                forecastService.locationManager?.requestWhenInUseAuthorization()
            }
            forecastService.locationManager?.startUpdatingLocation()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
                DispatchQueue.main.async {
                    self.cityLabel.text = city as String 
                }
                let cityName = city.replacingOccurrences(of: " ", with: "_")
                
                self.forecastService.getTenDayForecast(state: state as String, city: cityName, completion: {
                    (forecast) in
                    if let info = forecast {
                        self.foreCastData = info
                        DispatchQueue.main.async {
                            self.restore()
                        }
                    }
                })
            }
            
        })
        
    }
    
    override func restore() {
         super.restore()
         self.forecastTableView.reloadData()
    }
    
}
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCastData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = "forecastCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ForecastTableViewCell
        
        // Configure the cell...
        cell.populateDataOnCell(data: foreCastData[indexPath.row])
        
        return cell
    }
    
    
}
