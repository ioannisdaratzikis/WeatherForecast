//
//  Location.swift
//  Weather Forecast
//
//  Created by John Daratzikis on 19/03/2017.
//  Copyright © 2017 ioannisdaratzikis. All rights reserved.
//

import CoreLocation

class Location {

    static var sharedInstance = Location()
    
    private init(){}
    
    var latitude: Double!
    var longitude: Double!


}
