//
//  ResultViewController.swift
//  Weather_Task
//
//  Created by Vaishnavi on 22/11/24.
//

import UIKit
import CoreLocation

class ResultViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitude: String?
    var longitude: String?
    var urlString:String!
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var weatherImgView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherDegree: UILabel!
    @IBOutlet weak var weatherFeelslike: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let latitude = latitude, let longitude = longitude {
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(API_Key)&units=metric&cnt=1"
            print("Generated URL: \(urlString!)")
        }
        else {
            print("Latitude or Longitude is missing!")
        }
        self.fetchWeatherData()
    }
        
    func fetchWeatherData() {
        guard let url = URL(string: urlString ?? "") else {
            print("Invalid URL string")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        guard let self = self else { return }  // Unwrap self safely

            if let error = error {
                print("Error fetching weather data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }
            
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response: \(rawResponse)")
            }
            else {
                print("Failed to convert response data to string")
            }

            do { // Parse the JSON response
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)

                if let firstItem = weatherResponse.list.first {
                    let cityName = weatherResponse.city.name
                    let temperature = firstItem.main.temp
                    let feels_Like = firstItem.main.feels_like
                    let timestamp = firstItem.dt_txt
                    let weather = firstItem.weather.first
                    let main = weather?.main ?? ""
                    let formattedDate = self.getFormattedDate(from: timestamp)
                    
                    // Update UI elements on the main thread
                    DispatchQueue.main.async {
                        self.dateLbl.text = formattedDate
                        self.cityName.text = cityName
                        let roundedTemperature = Int(round(temperature))
                        self.weatherDegree.text = "\(roundedTemperature)°C"
                        let roundedFeelsLike = Int(round(feels_Like))
                        self.weatherFeelslike.text = "Feels Like" + " " + "\(roundedFeelsLike)°C"
                        self.setWeatherIcon(for: main)
                    }
                }
            }
            catch {
                print("Error parsing JSON: \(error)")
            }
        }
        task.resume()
    }

    func setWeatherIcon(for condition: String) {
        var iconName: String
        
        switch condition.lowercased() {
        case "rain":
            iconName = "cloud.rain.fill"
        case "clear":
            iconName = "sun.max.fill"
        case "clouds":
            iconName = "cloud.fill"
        case "snow":
            iconName = "cloud.snow.fill"
        default:
            iconName = "cloud.fill" // Default icon
        }
        self.weatherImgView.image = UIImage(systemName: iconName)
    }
    
    func getFormattedDate(from dateString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Input format
        
        if let date = inputDateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd MMM yyyy, EEEE"  // Output format with day
            let formattedDate = outputDateFormatter.string(from: date)
            print("The formattedDate is \(formattedDate)")
            return formattedDate
        }
        else {
            return "Invalid Date"
        }
    }
    
    func checkLocationAuthorizationStatus() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            openAppSettings(message: "Your Location permission seems to be disabled, do you want to enable it?", title: "")
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Unknown authorization status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            openAppSettings(message: "Your Location permission seems to be disabled, do you want to enable it?", title: "")
        @unknown default:
            print("Unknown authorization status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(API_Key)&units=metric&cnt=1"
            print("Generated URL: \(urlString!)")
            self.fetchWeatherData()
            print("Current Location: Latitude \(latitude), Longitude \(longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    //Mark: Button Actions
    @IBAction func didNotificationBtnTap(_ sender: Any) {
        let notificationVC = storyBd.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    @IBAction func didEditBtnTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didBackBtnTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didCurrentLocBtnTap(_ sender: Any) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        checkLocationAuthorizationStatus()
    }
}
