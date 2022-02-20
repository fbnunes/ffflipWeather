//
//  ViewController.swift
//  ffflipWeather
//
//  Created by Filipe Nunes on 19/02/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let networkManager = WeatherNetworkManager()
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var stackView : UIStackView!
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(handleAddPlaceButton)), UIBarButtonItem(image: UIImage(systemName: "thermometer"), style: .done, target: self, action: #selector(handleShowForecast)),UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(handleRefresh))]
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }


    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        let location = locations[0].coordinate
        latitude = location.latitude
        longitude = location.longitude
        print("Long", longitude.description)
        print("Lat", latitude.description)
        loadDataUsingCoordinates(lat: latitude.description, lon: longitude.description)
        
    }
    
    
    func loadData(city: String) {
        networkManager.fetchCurrentWeather(city: city) { (weather) in
             print("Current Temperature", weather.main.temp.kelvinToCeliusConverter())
             let formatter = DateFormatter()
             formatter.dateFormat = "dd MMM yyyy" //yyyy
             let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
             
//            print((String(weather.main.temp.kelvinToCeliusConverter()) + "°C"))
             DispatchQueue.main.async {
//                 print((String(weather.main.temp.kelvinToCeliusConverter()) + "°C"))
                 self.temperatureLabel.text = (String(weather.main.temp.kelvinToCeliusConverter()) + "°C")
//                 self.currentTemperatureLabel.text = (String(weather.main.temp.kelvinToCeliusConverter()) + "°C")
//                 self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
//                 self.tempDescription.text = weather.weather[0].description
//                 self.currentTime.text = stringDate
//                 self.minTemp.text = ("Min: " + String(weather.main.temp_min.kelvinToCeliusConverter()) + "°C" )
//                 self.maxTemp.text = ("Max: " + String(weather.main.temp_max.kelvinToCeliusConverter()) + "°C" )
//                 self.tempSymbol.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")
                 UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
             }
            
        }
    }
    
//    TODO: change the function in here
    func loadDataUsingCoordinates(lat: String, lon: String) {
        networkManager.fetchCurrentLocationWeather(lat: lat, lon: lon) { (weather) in
             print("Current Temperature", weather.main.temp.kelvinToCeliusConverter())
             let formatter = DateFormatter()
             formatter.dateFormat = "dd MMM yyyy" //yyyy
             let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
             print("came here")
             DispatchQueue.main.async {
                 self.temperatureLabel.text = (String(weather.main.temp.kelvinToCeliusConverter()) + "°C")
//                 self.currentTemperatureLabel.text = (String(weather.main.temp.kelvinToCeliusConverter()) + "°C")
//                 self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
//                 self.tempDescription.text = weather.weather[0].description
//                 self.currentTime.text = stringDate
//                 self.minTemp.text = ("Min: " + String(weather.main.temp_min.kelvinToCeliusConverter()) + "°C" )
//                 self.maxTemp.text = ("Max: " + String(weather.main.temp_max.kelvinToCeliusConverter()) + "°C" )
//                 self.tempSymbol.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")
                UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
             }
        }
    }

    //MARK: - Handlers
    @objc func handleAddPlaceButton() {
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
         alertController.addTextField { (textField : UITextField!) -> Void in
             textField.placeholder = "City Name"
         }
         let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
             let firstTextField = alertController.textFields![0] as UITextField
             print("City Name: \(firstTextField.text)")
            guard let cityname = firstTextField.text else { return }
            self.loadData(city: cityname)
         })
         let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
            print("Cancel")
         })
      

         alertController.addAction(saveAction)
         alertController.addAction(cancelAction)

         self.present(alertController, animated: true, completion: nil)
    }

    @objc func handleShowForecast() {
        self.navigationController?.pushViewController(ForecastViewController(), animated: true)
    }
    
    @objc func handleRefresh() {
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        loadData(city: city)
    }
    

    func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "", style: .plain, target: nil, action: nil)
       
    }



}

