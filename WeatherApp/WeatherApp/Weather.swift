//
//  Weather.swift
//  WeatherApp
//
//  Created by Marcel Chaucer on 8/9/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class Weather {
    
    var minTempF: Int
    var maxTempF: Int
    var minTempC: Int
    var maxTempC: Int
    var date: String
    var icon: String
    
    init?(from: [String : Any]) {
        
        guard let minTempFahrenheit =  from["minTempF"] as? Int,
        let maxTempFahrenheit = from["maxTempF"] as? Int,
        let minTempCelcius = from["minTempC"] as? Int,
        let maxTempCelcius = from["maxTempC"] as? Int,
        let date = from["dateTimeISO"] as? String,
        let icon = from["icon"] as? String
        else {return nil}
        
        self.minTempF = minTempFahrenheit
        self.maxTempF = maxTempFahrenheit
        self.minTempC = minTempCelcius
        self.maxTempC = maxTempCelcius
        self.date = date
        self.icon = icon
    }
    
    static func getWeather(from dict:[String:Any]) -> [Weather] {
        var weatherForecast = [Weather]()
        guard let response = dict["response"] as? [[String: Any]],
        let allTheWeather = response[0] as? [String: Any],
        let periods = allTheWeather["periods"] as? [[String:Any]] else {return []}
        for weatherDict in periods {
            if let theForecast = Weather(from: weatherDict) {
                weatherForecast.append(theForecast)
            }
        }
        return weatherForecast
    }

}
