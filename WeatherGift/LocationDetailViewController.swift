//
//  LocationDetailViewController.swift
//  WeatherGift
//
//  Created by Jackie Cochran on 10/8/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imageView: UIView!
    
    var weatherDetail: WeatherDetail!
    var locationIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadLocations()
        updateUserInterface()


        // Do any additional setup after loading the view.
    }
    
//    func loadLocations(){
//           guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations")
//               as? Data else{
//                   print("ERROR")
//           }
//       }
       
       
//       func saveLocations(){
//           let encoder = JSONEncoder()
//           if let encoded = try? encoder.encode(weatherLocations){
//               UserDefaults.standard.set(encoded, forKey: "weatherLocations")
//           }else{
//               print("Error: Saving encoding didn't work")
//           }
//        let decoder = JSONDecoder
//           if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation] {
//               self.weatherLocations = weatherLocation
//           }else{
//               print("ERROR")
//           }
//       }
    
    func updateUserInterface(){
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        let weatherLocation = pageViewController.weatherLocations[locationIndex]
        weatherDetail = WeatherDetail(name: weatherLocation.name, latitude: weatherLocation.latitude, longitude: weatherLocation.longitude)
        
        pageControl.numberOfPages = pageViewController.weatherLocations.count
        pageControl.currentPage = locationIndex
        
        weatherDetail.getData {
            DispatchQueue.main.async {
                self.dateLabel.text = self.weatherDetail.timezone
                self.placeLabel.text = self.weatherDetail.name
                self.temperatureLabel.text = "\(self.weatherDetail.temperature)°"
                self.summaryLabel.text = self.weatherDetail.summary
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LocationListViewController
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        destination.weatherLocations = pageViewController.weatherLocations
    }
    
    @IBAction func unwindFromLocationListViewController(segue: UIStoryboardSegue){
        let source = segue.source as! LocationListViewController
        locationIndex = source.selectedLocationIndex
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        pageViewController.weatherLocations = source.weatherLocations
        pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: locationIndex)], direction: .forward, animated: false, completion: nil)
    }

    @IBAction func pageControlTapped(_ sender: UIPageControl) {
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        var directionBool: UIPageViewController.NavigationDirection = .forward
        if sender.currentPage < locationIndex{
            directionBool = .reverse
        }
        pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: sender.currentPage)], direction: directionBool, animated: true, completion: nil)
    }
    
    
    
}
