//
//  WeatherDetail.swift
//  WeatherGift
//
//  Created by Jackie Cochran on 10/12/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//

import Foundation

class WeatherDetail: WeatherLocation {
    
    struct Result: Codable {
        var timezone: String
        var current: Current
    }
    struct Current: Codable{
        var dt: TimeInterval
        var temp: Double
        var weather: [Weather]
    }
    struct Weather: Codable {
        var description: String
        var icon: String
    }
    
    var timezone = ""
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIKeys.openWeatherKey)"
        print(urlString)
        
        //Create a URL
        guard let url = URL(string:urlString) else {
            print("ERROR: Could not create a URL from \(urlString)")
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
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let result = try JSONDecoder().decode(Result.self, from: data!)
                print("\(result)")
                print("The time zone for \(self.name) is \(result.timezone)")
                self.timezone = result.timezone
                self.currentTime = result.current.dt
                self.temperature = Int(result.current.temp.rounded())
                self.summary = result.current.weather[0].description
                self.dailyIcon = result.current.weather[0].icon
            } catch {
                print("JSON ERROR: \(error.localizedDescription)")
            }
            

        }
        task.resume()
    }
}
