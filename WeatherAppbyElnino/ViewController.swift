//
//  ViewController.swift
//  WeatherAppbyElnino
//
//  Created by El nino Cholo on 2020/06/06.
//  Copyright © 2020 El nino Cholo. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate ,getCityName{
   
    

    var weatherfields:WeatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var temperaturLabel: UILabel!
    
    @IBOutlet weak var conditionIamge: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    let LocationManager:CLLocationManager = CLLocationManager()
   
    
    var weatherURL :String = "http://api.openweathermap.org/data/2.5/weather"
    var AppID:String = "6b5f4ede3ccb0fc1a67feecad0e23773"
    
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.delegate = self
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.requestWhenInUseAuthorization()
        LocationManager.startUpdatingLocation()
    }
    
  
    func getLocationWeatherData(url:String,parameters:[String:String])
    {
        Alamofire.request(url, method: HTTPMethod.get, parameters: parameters).responseJSON { (weatherData) in
            
            if weatherData.result.isSuccess
            {
                if let weather = weatherData.result.value
                {
//                    print(weather)
                    
                    let weatherJSON:JSON = JSON(weather)
                    self.extractData(json: weatherJSON)
                }
                
                
            }else if weatherData.result.isFailure
            {
                print("Couldnt get weather data for this specific location")
            }
        }
        
        
    }
    
    
    
    func extractData(json:JSON)
    {
        weatherfields.city = json["name"].stringValue
        print(weatherfields.city)
        weatherfields.Conditions = json["weather"][0]["id"].intValue
        print(weatherfields.Conditions)
        weatherfields.temperature = Int(json["main"]["temp"].doubleValue - 275.15)
        print(weatherfields.temperature)
        
        UpdateUI()
    }
    
    func UpdateUI()
    {
        temperaturLabel.text = "\(weatherfields.temperature)°"
        cityLabel.text = weatherfields.city
        conditionIamge.image = UIImage(named: weatherfields.updateWeatherIcon(condition: weatherfields.Conditions))
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0
        {
            let locationdata = location.coordinate
            print(locationdata)
            let latitude = String(locationdata.latitude)
            let longitude = String(locationdata.longitude)
            print(latitude)
            print(longitude)
          
            let params:[String:String] = ["lat":latitude,"lon":longitude,"appid": AppID]
            getLocationWeatherData(url: weatherURL, parameters: params)
            
        }else
        {
            print("No location found at this point")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Location not found"
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
      if segue.identifier == "passData"
      {
        let secondVC = segue.destination as! SecondViewController
            secondVC.erickelninoDelegate = self
        
      }
        
    }
    
    func passCityName(City: String) {
        let cityname = City
        
        let params:[String:String] = ["q":cityname,"appid":AppID]
        getLocationWeatherData(url:weatherURL,parameters:params)
    }
   
    @IBAction func forward(_ sender: Any)
    {
        performSegue(withIdentifier: "passData", sender: self)
    }
    
    

}

