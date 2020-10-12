//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Jackie Cochran on 10/6/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var latitude: Double
    var longitude: Double
    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData(completed: @escaping () -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIKeys.openWeatherKey)"
        print(urlString)
        
        //Create a URL
        guard let url = URL(string:urlString) else {
            print("ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
        
        //Create a URLSession
        let session = URLSession.shared
        
        //get data with .dataTask
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            
            //note there are some additional things that could go wrong when using URLSession but we shouldn't experience them, so we'll ignore testing for these for now...
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            completed()
            

        }
        task.resume()
        
    }
}
