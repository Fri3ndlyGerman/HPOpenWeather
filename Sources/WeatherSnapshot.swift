//
//  WeatherSnapshot.swift
//  HPOpenWeather
//
//  Created by Henrik Panhans on 28.04.19.
//  Copyright © 2019 Henrik Panhans. All rights reserved.
//

import Foundation

public protocol WeatherSnapshot: Codable {
    /// The time of data calculation in UTC time
    var timeOfCalculation: Date { get }
    /// Holds the main information of the request, such as temperature, humidity, pressure, etc.
    var main: Main { get }
    /// List of current weather conditions
    var conditions: [WeatherCondition] { get }
    /// Current wind information, like wind speed and degrees
    var wind: Wind { get }
    /// Information about snowfall in the last one or three hours
    var snow: Precipitation { get }
    /// Information about rainfall in the last one or three hours
    var rain: Precipitation { get }
    
    /// Internal type to handle missing "snow" key in JSON response
    var _snow: Precipitation? { get }
    /// Internal type to handle missing "rain" key in JSON response
    var _rain: Precipitation? { get }
}
