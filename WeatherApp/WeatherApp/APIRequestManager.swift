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
    let request = URLRequest(url: url)
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        if error != nil {
            print("Error during session: \(String(describing: error))")
        }
        guard let validData = data else { return }
        callback(validData)
        }.resume()
}
}

