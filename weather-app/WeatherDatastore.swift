//
//  WeatherDatastore.swift
//  weather-app
//
//  Created by liusy182 on 10/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherDatastore {
    let APIKey = "004b8d27c630953a05f1aca8097f5d9e"
    
    func retrieveCurrentWeatherAtLat(
        lat: CLLocationDegrees,
        lon: CLLocationDegrees,
        block: (weatherCondition: WeatherCondition) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/weather?APPID=\(APIKey)"
        let params = ["lat":lat, "lon":lon]
        
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let json):
                    let json = JSON(json)
                    block(weatherCondition: self.createWeatherConditionFronJson(json))
                case .Failure(_, let error):
                    print("Error: \(error)")
                }
        }
    }
    
    func retrieveDailyForecastAtLat(
        lat: Double,
        lon: Double,
        dayCnt: Int,
        block: (weatherConditions: Array<WeatherCondition>) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/forecast/daily?APPID=\(APIKey)"
        let params = ["lat":lat, "lon":lon, "cnt":Double(dayCnt+1)]
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let json):
                    let json = JSON(json)
                    let list: Array<JSON> = json["list"].arrayValue
                    let weatherConditions: Array<WeatherCondition> = list.map(){
                        return self.createDayForecastFronJson($0)
                    }
                    let count = weatherConditions.count
                    let daysWithoutToday = Array(weatherConditions[1..<count])
                    block(weatherConditions: daysWithoutToday)
                case .Failure(_, let error):
                    print("Error: \(error)")
                }
        }
    }
    
    func retrieveHourlyForecastAtLat(
        lat: CLLocationDegrees,
        lon: CLLocationDegrees,
        block: (weatherConditions: Array<WeatherCondition>) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?APPID=\(APIKey)"
        let params = ["lat":lat, "lon":lon]
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { request, response, result in
                switch result {
                case .Success(let json):
                    let json = JSON(json)
                    let list: Array<JSON> = json["list"].arrayValue
                    
                    let weatherConditions: Array<WeatherCondition> = list.map() {
                        return self.createWeatherConditionFronJson($0)
                    }
                    block(weatherConditions: weatherConditions)
                case .Failure(_, let error):
                    print("Error: \(error)")
                }
        }
    }
    
    func createWeatherConditionFronJson(json: JSON) -> WeatherCondition{
        let name = json["name"].string
        let weather = json["weather"][0]["main"].stringValue
        let icon = json["weather"][0]["icon"].stringValue
        let dt = json["dt"].doubleValue
        let time = NSDate(timeIntervalSince1970: dt)
        let tempKelvin = json["main"]["temp"].doubleValue
        let maxTempKelvin = json["main"]["temp_max"].doubleValue
        let minTempKelvin = json["main"]["temp_min"].doubleValue
        
        return WeatherCondition(
            cityName: name,
            weather: weather,
            icon: IconType(rawValue: icon),
            time: time,
            tempKelvin: tempKelvin,
            maxTempKelvin: maxTempKelvin,
            minTempKelvin: minTempKelvin)
    }
    
    func createDayForecastFronJson(json: JSON) -> WeatherCondition{
        let name = ""
        let weather = json["weather"][0]["main"].stringValue
        let icon = json["weather"][0]["icon"].stringValue
        let dt = json["dt"].doubleValue
        let time = NSDate(timeIntervalSince1970: dt)
        let tempKelvin = json["temp"]["day"].doubleValue
        let maxTempKelvin = json["temp"]["max"].doubleValue
        let minTempKelvin = json["temp"]["min"].doubleValue
        
        return WeatherCondition(
            cityName: name,
            weather: weather,
            icon: IconType(rawValue: icon),
            time: time,
            tempKelvin: tempKelvin,
            maxTempKelvin: maxTempKelvin,
            minTempKelvin: minTempKelvin)
    }
}