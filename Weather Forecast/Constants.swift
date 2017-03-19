//
//  Constants.swift
//  Weather Forecast
//
//  Created by John Daratzikis on 18/03/2017.
//  Copyright © 2017 ioannisdaratzikis. All rights reserved.
//

import Foundation

let sheme = "http://"
let hostname = "api.openweathermap.org/"
let path1 = "data/2.5/weather?"
let path2 = "data/2.5/forecast/daily?"

let latitude = "lat="
let longitude = "&lon="
let days = "&cnt=10"

let appId = "&appid="
let apiKey = "f978537a55e9535979fc541fefcce46d"

let currentWeatherUrl = sheme+hostname+path1+latitude+String(Location.sharedInstance.latitude)+longitude+String(Location.sharedInstance.longitude)+appId+apiKey
let forecastUrl = sheme+hostname+path2+latitude+String(Location.sharedInstance.latitude)+longitude+String(Location.sharedInstance.longitude)+days+appId+apiKey
