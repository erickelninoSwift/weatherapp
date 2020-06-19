//
//  SecondViewController.swift
//  WeatherAppbyElnino
//
//  Created by El nino Cholo on 2020/06/07.
//  Copyright © 2020 El nino Cholo. All rights reserved.
//

import UIKit

protocol getCityName
{
    func passCityName(City:String)
}

class SecondViewController: UIViewController
{

@IBOutlet weak var ErickFields: UITextField!
    
    var city:String = ""
    
    
    var erickelninoelegate:getCityName?
   
    
    @IBAction func button_Pressed(_ sender: AnyObject)
    {

            erickelninoelegate!.passCityName(City:ErickFields.text!)
             dismiss(animated: true, completion: nil)

      
    }
    
   
    
    @IBAction func takeBack(_ sender: AnyObject)
    {
         self.dismiss(animated: true, completion:nil)
    }
    
 }

