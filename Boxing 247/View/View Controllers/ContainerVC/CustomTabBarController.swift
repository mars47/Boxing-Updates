//
//  CustomTabBarController.swift
//  Boxing 247
//
//  Created by Omar on 30/11/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var containerVC : ContainerVC?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let weightDivisionVC = (viewControllers![0] as! UINavigationController).viewControllers[0] as! WeightDivisionVC
        
  //      weightDivisionVC.containerVC = containerVC
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? NewsFeedVC {
            
            print("Yay it worked")
            _ = ""
            
        } else {
            
            print(segue.destination.self)
             _ = ""
        }
        
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
