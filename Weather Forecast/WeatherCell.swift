//
//  WeatherCell.swift
//  Weather Forecast
//
//  Created by John Daratzikis on 19/03/2017.
//  Copyright © 2017 ioannisdaratzikis. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forecast: Forecast){
    
        lowTemp.text = String(forecast.lowTemp)
        highTemp.text = String(forecast.lowTemp)
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }

   

}
