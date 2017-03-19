//
//  WeatherViewController.swift
//  Weather Forecast
//
//  Created by John Daratzikis on 18/03/2017.
//  Copyright © 2017 ioannisdaratzikis. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var forecastWeather = Forecast()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationAuthStatus()
        
        currentWeather.downloadWeatherDetails {
            DispatchQueue.main.async {
                self.dateLabel.text = self.currentWeather.date
                self.currentTempLabel.text = String(self.currentWeather.currentTemp)
                self.locationLabel.text = self.currentWeather.cityName
                self.currentWeatherTypeLabel.text = self.currentWeather.weatherType
                self.currentWeatherIcon.image = UIImage(named: self.currentWeather.weatherType)
            }
        }
        
        forecastWeather.downloadForecastDetails { (forecasts) in
            self.forecasts = forecasts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
    func locationAuthStatus(){
    
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
        }else {
        
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        
        }
        
    }


    //MARK: - Setup the table view delegate & datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
        
            cell.configureCell(forecast: self.forecasts[indexPath.row])
            return cell
        }else {
        
            return WeatherCell()
        }
        
        
    }
    
    
}

