//
//  NotificationViewController.swift
//  Weather_Task
//
//  Created by Neshwa on 23/11/24.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func didBackBtnTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
