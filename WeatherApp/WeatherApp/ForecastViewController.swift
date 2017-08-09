//
//  ViewController.swift
//  WeatherApp
//
//  Created by Marcel Chaucer on 8/9/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var forecast: [Weather] = []
    var apiEndPoint = "http://api.aerisapi.com/forecasts/11101?client_id=V6f4PQV2VjejJj7R5SffF&client_secret=1216GsGhl6Fdxmu5wD0vnidN6HolIsSRNlWBTZMU"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var weatherToggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecast = getWeather()
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
    }
    
    //Make network call and make an array of Weather objects
    
    func getWeather() -> [Weather] {
        APIRequestManager.manager.getData(endPoint: apiEndPoint) { data in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]),
                    let forecast = jsonData as? [String:Any] {
                    
                    self.forecast = Weather.getWeather(from: forecast)
                 
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        return self.forecast
    }

    //Reload tableview each time switch is toggled
    @IBAction func toggleWeather(_ sender: UISwitch) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        
        let weather = forecast[indexPath.row]
        
        //Set icon image from assets
        let imageString = weather.icon.components(separatedBy: ".")[0]
        let iconImage = UIImage(named: imageString)!
        
        //Extract just date from json response
        let index = weather.date.index(weather.date.startIndex, offsetBy: 10)
        let dateString = weather.date.substring(to: index)
        
        cell.dateLabel.text = dateString
        
        //This will let you display Celsius or Fahrenheit depending on the value of the toggle switch beneath the tableView
        if self.weatherToggle.isOn {
            cell.highTempLabel.text = "High: \(weather.maxTempF)°F"
            cell.lowTempLabel.text = "Low: \(weather.minTempF)°F"
        } else {
            cell.highTempLabel.text = "High: \(weather.maxTempC)°C"
            cell.lowTempLabel.text = "Low: \(weather.minTempC)°C"
        }
        cell.weatherIconImage.image = iconImage
        
        return cell
    }


}

