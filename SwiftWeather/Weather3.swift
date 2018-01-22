//
//  Weather3.swift
//  SwiftWeather
//
//  Created by Sanyam Yadav on 22/01/2018.
//  Copyright © 2018 Sanyam Yadav. All rights reserved.
//



import Foundation
import CoreLocation

struct Weather3{
    let city: String
    //   let desc:String
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        
        guard let city = json["name"] as? String else {throw SerializationError.missing("city is missing")}
        // print(summary + "summary is this")
        
       self.city = city
        
    }
    
    private static let API_KEY = "khwbacqbjerov"
    
    static let basePath = "http://samples.openweathermap.org/data/2.5/forecast/daily?"
    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather3]?) -> ()) {
        
        
        let url = basePath + "lat=\(location.latitude)" + "&lon=\(location.longitude)&cnt=10" + "&appid=" + API_KEY
        print(url)
        
        
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather3] = []
            
            if let data = data {
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                                if let dailyData = json["city"] as? [String:Any] {
                                    
                                    if let weather3Object = try? Weather3(json: dailyData) {
                                        forecastArray.append(weather3Object)
                                        
                                        
                                        print("-weather3Object-")
                                        print(weather3Object)
                                        print("=weather3Object=")
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
