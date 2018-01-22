
import Foundation
import CoreLocation

struct Weather {
    let summary:String
    let icon:String
    let temperature:String
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        guard let summary = json["main"] as? String else {throw SerializationError.missing("summary is missing")}
        print(summary + "summary is this")
        guard let icon = json["main"] as? String else {throw SerializationError.missing("icon is missing")}
        print(icon + "this is icon")
        guard let temperature = json["description"] as? String else {throw SerializationError.missing("temp is missing")}
        print(temperature )
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        
    }
    
    //http://samples.openweathermap.org/data/2.5/forecast/daily?lat=37.785834&lon=62.66&cnt=10&&appid=khwbacqbjerov
    
  
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()) {
        
        let API_KEY = "khwbacqbjerov"
        
         let basePath = "http://samples.openweathermap.org/data/2.5/forecast/daily?"
    
        
        
        let url = basePath + "lat=\(location.latitude)" + "&lon=\(location.longitude)&cnt=10" + "&appid=" + API_KEY
        print(url)
        
        
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            
            if let data = data {
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        
                        if let lhj = json["list"] as? [[String:Any]] {
                            for ol in lhj {
                                print(ol)
                                if let dailyData = ol["weather"] as? [[String:Any]] {
                                    print(dailyData)
                                    for dataPoint in dailyData {
                                        if let weatherObject = try? Weather(json: dataPoint) {
                                            forecastArray.append(weatherObject)
                                        }
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
