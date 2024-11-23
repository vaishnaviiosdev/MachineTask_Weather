//
//  Untitled.swift
//  Weather_Task
//
//  Created by Neshwa on 23/11/24.
//

import Foundation
import UIKit

extension NSObject {
    
    func openAppSettings(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(1)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        TopMostViewController().present(alertController, animated: true, completion: nil)
    }
    
    public func TopMostViewController() -> UIViewController {
        return self.TopMostViewController(withRootViewController: (UIApplication.shared.keyWindow?.rootViewController!)!)
    }
    
    public func TopMostViewController(withRootViewController rootViewController: UIViewController) -> UIViewController {
        if (rootViewController is UITabBarController) {
            let tabBarController = (rootViewController as! UITabBarController)
            return self.TopMostViewController(withRootViewController: tabBarController.selectedViewController!)
        }
        else if (rootViewController is UINavigationController) {
            let navigationController = (rootViewController as! UINavigationController)
            return self.TopMostViewController(withRootViewController: navigationController.visibleViewController!)
        }
        else if rootViewController.presentedViewController != nil {
            let presentedViewController = rootViewController.presentedViewController!
            return self.TopMostViewController(withRootViewController: presentedViewController)
        }
        else {
            return rootViewController
        }
    }
}
