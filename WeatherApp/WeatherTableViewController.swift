
import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var LabelOne: UILabel!
    
    @IBOutlet weak var LabelTwo: UILabel!
    
    @IBOutlet weak var LabelThree: UILabel!
    
    @IBOutlet weak var LabelFour: UILabel!
    
    @IBOutlet weak var ImageOne: UIImageView!
    
    
    var forecastData = [Weather]()
    var forecastData2 = [Weather2]()
    var forecastData3 = [Weather3]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
   //     searchBar.delegate = self

        updateWeatherForLocation(location: "New York")
        updateWeatherForLocation2(location: "New York")
   //     updateWeatherForLocation3(location: "New York")

    }
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            
            updateWeatherForLocation(location: locationString)
            updateWeatherForLocation2(location: locationString)
 //           updateWeatherForLocation3(location: locationString)

        }
        
    }
    
    func updateWeatherForLocation (location:String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    Weather.forecast(withLocation: location.coordinate, completion: { (results:[Weather]?) in
                        
                        if let weatherData = results {
                            self.forecastData = weatherData
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    })
                }
            }
        }
    }
    
    func updateWeatherForLocation2 (location:String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    Weather2.forecast(withLocation: location.coordinate, completion: { (results:[Weather2]?) in
                        
                        if let weatherData = results {
                            self.forecastData2 = weatherData
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    })
                }
            }
        }
    }
    
  /*  func updateWeatherForLocation3 (location:String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if let location = placemarks?.first?.location {
                    Weather3.forecast(withLocation: location.coordinate, completion: { (results:[Weather3]?) in
                        
                        if let weatherData = results {
                            self.forecastData3 = weatherData
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                        
                    })
                }
            }
        }
    }

*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return forecastData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        
        return dateFormatter.string(from: date!)
        
        
        
    }
    

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let weatherObject = forecastData[indexPath.section]
        
        let weather2Object = forecastData2[indexPath.section]
        
        



        
  
        
        //
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        
        
        dateFormatter.dateFormat = "EEEE "
        let currentDayString: String = dateFormatter.string(from: date)
        
        
        
     //   let dateFormatter = DateFormatter()
    //    dateFormatter.dateFormat = "EEEE,MMMM dd, yyyy"
        
        
        LabelOne.text = "Today, \(currentDateString)"
        LabelTwo.text = "\(Double(weather2Object.icon - 273.15))"
       
        LabelFour.text =  weatherObject.icon
        ImageOne.image = UIImage(named: weatherObject.icon)
        LabelThree.text = "Tawarano" // weather3Object.city

        cell.textLabel?.text =  weatherObject.summary + "             \(Double(weather2Object.icon - 273.15)) "
        cell.detailTextLabel?.text = weatherObject.temperature + "           \(Double(weather2Object.summary - 273.15))"
        cell.imageView?.image = UIImage(named: weatherObject.icon)
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
