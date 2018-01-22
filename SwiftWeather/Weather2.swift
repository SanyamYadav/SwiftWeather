//
//  Weather2.swift
//  SwiftWeather
//
//  Created by Sanyam Yadav on 22/01/2018.
//  Copyright © 2018 Sanyam Yadav. All rights reserved.
//



import Foundation
import CoreLocation

struct Weather2{
    let summary:Double
    let icon:Double
    let temperature:Double
    //   let desc:String
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        guard let summary = json["min"] as? Double else {throw SerializationError.missing("summary is missing")}
        // print(summary + "summary is this")
        
        
        guard let icon = json["max"] as? Double else {throw SerializationError.missing("icon is missing")}
        //  print(icon + "this is icon")
        
        guard let temperature = json["max"] as? Double else {throw SerializationError.missing("temp is missing")}
        print(temperature )
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature

    }
    
    private static let API_KEY = "khwbacqbjerov"
    
    static let basePath = "http://samples.openweathermap.org/data/2.5/forecast/daily?"
    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather2]?) -> ()) {
        
        
        let url = basePath + "lat=\(location.latitude)" + "&lon=\(location.longitude)&cnt=10" + "&appid=" + API_KEY
        print(url)
        
        
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather2] = []
            
            if let data = data {
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        if let list = json["list"] as? [[String:Any]] {
                            
                            
                            for elements in list {
                                print(elements)
                                if let dailyData = elements["temp"] as? [String:Any] {
                                                                      
                                    if let weather2Object = try? Weather2(json: dailyData) {
                                        forecastArray.append(weather2Object)
                                        print("-weather2Object-")
                                        print(weather2Object)                                    
                                        print("=weather2Object=")
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
