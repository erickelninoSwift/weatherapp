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


class ViewController: UIViewController,CLLocationManagerDelegate {

    
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
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0
        {
            let locationdata = location.coordinate
            print(locationdata)
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Location not found"
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
    }
   
    
    @IBAction func forward(_ sender: Any)
    {
        performSegue(withIdentifier: "passData", sender: self)
    }
    
    

}

