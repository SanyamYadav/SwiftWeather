//
//  Weather.swift
//  SwiftWeather
//
//  Created by Sanyam Yadav on 21/01/2018.
//  Copyright © 2018 Sanyam Yadav. All rights reserved.
//

import Foundation
import CoreLocation

struct Weather {
    let summary:String
    let main:String
    let temperature:Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        guard let summary = json["country"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let main = json["main"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let temperature = json["temp_max"] as? Double else {throw SerializationError.missing("temp is missing")}
        
        self.summary = summary
        self.main = main
        self.temperature = temperature
        
    }
    
    
    static let basePath = "http://samples.openweathermap.org/data/2.5/weather?lat=37.785834&lon=62.66&appid=khwbacqbjerov"
    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()) {
        
        let url = "http://samples.openweathermap.org/data/2.5/weather?lat=37.785834&lon=62.66&appid=khwbacqbjerov"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["main"] as? [String:Any] {
                            if let dailyData = dailyForecasts["temp"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
                
            }
            
            
        }
        
        task.resume()
        
        
        
        
        
        
        
        
        
    }
    
    
}
