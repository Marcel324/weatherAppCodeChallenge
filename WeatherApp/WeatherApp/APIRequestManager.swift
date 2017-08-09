//
//  APIRequestManager.swift
//  WeatherApp
//
//  Created by Marcel Chaucer on 8/9/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation

class APIRequestManager {

static let manager = APIRequestManager()
private init() {}

func getData(endPoint: String, callback: @escaping (Data?) -> Void) {
    guard let url = URL(string: endPoint) else { return }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

//    request.addValue("Accept", forHTTPHeaderField: "application/json")
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        if error != nil {
            print("Error during session: \(error)")
        }
        guard let validData = data else { return }
        callback(validData)
        }.resume()
}
}

