//
//  pageViewController.swift
//  WeatherGift
//
//  Created by Jackie Cochran on 10/11/20.
//  Copyright © 2020 Jackie Cochran. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var weatherLocations: [WeatherLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        loadLocations()
        setViewControllers([createLocationDetailViewController(forPage: 0)], direction: .forward, animated: false, completion: nil)


        // Do any additional setup after loading the view.
    }
    
    func loadLocations(){
        guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations")
            as? Data else{
                print("ERROR")
                //TODO: Get user location for the first element in weatherLocation
                weatherLocations.append(WeatherLocation(name: "CURRENT LOCATION", latitude: 20.20, longitude: 20.20))
            return
        }
        if weatherLocations.isEmpty {
            //TODO: Get user location for the first element in weatherLocation
                weatherLocations.append(WeatherLocation(name: "CURRENT LOCATION", latitude: 20.20, longitude: 20.20))
        }
    }
    
//    func saveLocations(){
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(weatherLocations){
//            UserDefaults.standard.set(encoded, forKey: "weatherLocations")
//        }else{
//            print("Error: Saving encoding didn't work")
//        }
//     let decoder = JSONDecoder
//        if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation] {
//            self.weatherLocations = weatherLocation
//        }else{
//            print("ERROR")
//        }
//    }
    
    func createLocationDetailViewController(forPage page: Int) -> LocationDetailViewController {
        let detailViewController = storyboard!.instantiateViewController(identifier: "LocationDetailViewController") as! LocationDetailViewController
        detailViewController.locationIndex = page
    }

}
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as! LocationDetailViewController {
            if currentViewController.locationIndex > 0{
                return createLocationDetailViewController(forPage: currentViewController.locationIndex - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as! LocationDetailViewController{
            if currentViewController.locationIndex < weatherLocations.count - 1 {
                return currentViewController(forPage: currentViewController.locationIndex + 1)
            }
        }
    }
    
}
