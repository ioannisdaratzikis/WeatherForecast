//
//  Forecast.swift
//  Weather Forecast
//
//  Created by John Daratzikis on 19/03/2017.
//  Copyright © 2017 ioannisdaratzikis. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {

    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    //var forecasts = [Forecast]()
    
    var date: String {
    
        if _date == nil {
        
            _date = ""
        }
        
        return _date
    
    }
    
    var weatherType: String {
        
        if _weatherType == nil {
            
            _weatherType = ""
        }
        
        return _weatherType
        
    }
    
    var highTemp: String {
        
        if _highTemp == nil {
            
            _highTemp = ""
        }
        
        return _highTemp
        
    }

    var lowTemp: String {
        
        if _lowTemp == nil {
            
            _lowTemp = ""
        }
        
        return _lowTemp
        
    }
    
    init (weatherDict: [String: AnyObject]) {
        
        if let temp = weatherDict["temp"] as? [String: AnyObject]{
        
            if let min = temp["min"] as? Double {
            
                self._lowTemp = String(min - 273.15)
            }
            
            if let max = temp["max"] as? Double {
            
                self._highTemp = String(max - 273.15)
                
            }

        }
        
        if let weather = weatherDict["weather"] as? [[String:AnyObject]]{
        
            if let main = weather[0]["main"] as? String{
            
                self._weatherType = main
                
            }
        
        }
        
        if let date = weatherDict["dt"] as? Double {
        
            let unixDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixDate.dayOfWeek()
        
        }
    }
    
    init() {
        
    }

    func downloadForecastDetails(completed: @escaping ([Forecast])->()){
    
        var forecasts = [Forecast]()
        
        let fUrl = URL(string: forecastUrl)!
        Alamofire.request(fUrl).responseJSON { (response) in
            let result = response.result
            
            if let dict = result.value as? [String: AnyObject] {
                
                if let list = dict["list"] as? [[String: AnyObject]]{
                
                    for obj in list {
                    
                        let forecast = Forecast(weatherDict: obj)
                        forecasts.append(forecast)
                    }
                    
                }
                forecasts.remove(at: 0)
            
            }
            completed(forecasts)
        }
 
    
    }
    

}

extension Date {

    func dayOfWeek() -> String {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    
    }

}
