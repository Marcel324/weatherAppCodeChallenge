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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecast = getWeather()
        
    }
    
    func getWeather() -> [Weather] {
        APIRequestManager.manager.getData(endPoint: "http://api.aerisapi.com/forecasts/11101?client_id=V6f4PQV2VjejJj7R5SffF&client_secret=1216GsGhl6Fdxmu5wD0vnidN6HolIsSRNlWBTZMU") { data in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]),
                    let forecast = jsonData as? [String:Any] {
                    
                    self.forecast = Weather.getWeather(from: forecast)
                 
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.backgroundColor = .red
                    }
                }
            }
        }
        return forecast
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
        
        cell.dateLabel.text = weather.date
        cell.highTempLabel.text = "High: \(weather.maxTempF)"
        cell.lowTempLabel.text = "Low: \(weather.minTempF)"
        
        
        return cell
    }


}

