//
//  aboutViewController.swift
//  Weather_Task
//
//  Created by Vaishnavi on 22/11/24.
//

import UIKit

class aboutViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var waetherDescLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.waetherDescLabel.text = weatherDescription
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.loadContent()
    }
    
    func loadContent() {
        if let url = URL(string: imageUrlString) {
            downloadImage(from: url)
        }
    }
    
    func downloadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            print("The response is \(data)")
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
                self?.cacheImage(image, for: url)
            }
        }
        task.resume()
    }
    
    func cacheImage(_ image: UIImage, for url: URL) {
        // Asynchronously download the image
        let fileName = url.lastPathComponent
        print("Caching image with file name: \(fileName)") 
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            
            // Save the image to disk
            if let data = image.jpegData(compressionQuality: 1.0) {
                do {
                    try data.write(to: fileURL)
                    print("Image cached successfully at: \(fileURL.path)") //
                }
                catch {
                    print("Error caching image: \(error.localizedDescription)")
                }
            }
            else {
                print("Failed to convert image to JPEG data for caching.")
            }
        }
    }
    
    //Mark :- Button Action
    @IBAction func didBackBtnTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
