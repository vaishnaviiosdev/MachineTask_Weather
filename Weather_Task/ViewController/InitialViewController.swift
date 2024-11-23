//
//  ViewController.swift
//  Weather_Task
//
//  Created by Vaishnavi on 22/11/24.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Mark :- Button Actions
    @IBAction func didAboutBtnTap(_ sender: Any) {
        let aboutVC = storyBd.instantiateViewController(withIdentifier: "aboutViewController") as! aboutViewController
        self.navigationController?.pushViewController(aboutVC, animated: false)
    }
    
    @IBAction func didGetStartedBtnTap(_ sender: Any) {
        let landingVC = storyBd.instantiateViewController(withIdentifier: "LandingViewController") as! LandingViewController
        self.navigationController?.pushViewController(landingVC, animated: false)
    }
}

