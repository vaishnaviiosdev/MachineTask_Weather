//
//  LandingViewController.swift
//  Weather_Task
//
//  Created by Vaishnavi on 22/11/24.
//

import UIKit

class LandingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var latitudeTxtfield: UITextField!
    @IBOutlet weak var longitudeTxtfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.latitudeTxtfield.delegate = self
        self.longitudeTxtfield.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToResultPage(latitude: String, longitude: String) {
        let resultVC = storyBd.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultVC.latitude = latitude
        resultVC.longitude = longitude
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            return true
        }

        let characterSet = CharacterSet(charactersIn: "0123456789.") //Only allowed numbers & dot.
        let filteredString = string.filter { characterSet.contains($0.unicodeScalars.first!) }
        return string == filteredString
    }
    
    //Mark : Button Actions
    @IBAction func didNotificationBtnTap(_ sender: Any) {
        let notificationVC = storyBd.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    @IBAction func didgetWeatherBtnTap(_ sender: Any) {
        guard let latitudeText = latitudeTxtfield.text, !latitudeText.isEmpty else {
            self.showAlert(message: "Please enter a valid latitude.")
            return
        }
                
        guard let longitudeText = longitudeTxtfield.text, !longitudeText.isEmpty else {
            self.showAlert(message: "Please enter a valid longitude.")
            return
        }
        
        self.navigateToResultPage(latitude: latitudeText, longitude: longitudeText)
    }
}
