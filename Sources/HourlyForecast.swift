//
//  Forecast.swift
//  OpenWeatherSwift
//
//  Created by Henrik Panhans on 12.02.17.
//  Copyright © 2017 Henrik Panhans. All rights reserved.
//

import Foundation

/// Codable type that holds weather forecast information in an hourly frequency
public struct HourlyForecast: Codable {
    /// The nearest city, returned by the API
    public var city: City
    /// The number of measurements returned by the API
    public var numberOfDataPoints: Int
    /// The datapoints returned by the API
    public var dataPoints: [DataPoint]
    
    /// Codable type that represents a data points based on an hourly frequency
    public struct DataPoint: WeatherSnapshot, PrecipitationOptional {
        /// The timestamp of the forecast measurement
        public var forecastTimeStamp: Date
        /// The time of data calculation on the server. Data is refreshed every 10 minutes
        public var timeOfCalculation: Date {
            return DataPoint.dateFormatter.date(from: _timeOfCalculation ?? "1970-01-01 00:00:00") ?? Date.distantPast
        }
        public var main: Main
        public var condition: WeatherCondition {
            return self._condition?.first ?? WeatherCondition.unknown
        }
        public var wind: Wind
        public var snow: Precipitation { return _snow ?? Precipitation.none }
        public var rain: Precipitation { return _rain ?? Precipitation.none }
        public var cloudCoverage: Int { return self._clouds?.all ?? 0 }
        
        static private var dateFormatter: DateFormatter {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter
        }
        
        internal var _snow: Precipitation?
        internal var _rain: Precipitation?
        internal var _clouds: Clouds?
        internal var _timeOfCalculation: String?
        internal var _condition: [WeatherCondition]?
        
        enum CodingKeys: String, CodingKey {
            case forecastTimeStamp = "dt"
            case _timeOfCalculation = "dt_txt"
            case _snow = "snow"
            case _rain = "rain"
            case main
            case _condition = "weather"
            case wind
            case _clouds = "clouds"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case city
        case numberOfDataPoints = "cnt"
        case dataPoints = "list"
    }
}
