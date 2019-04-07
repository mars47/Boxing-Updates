//
//  247ViewController.swift
//  Boxing 247
//
//  Created by Omar  on 06/04/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

class B247ViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var delegate: NewsFeedVCDelegate?
    var mainStoryboard: UIStoryboard!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureController(withProperties viewController: B247ViewController, isCenter: Bool) {
        
        centerNavigationController = viewController.centerNavigationController
        delegate = viewController.delegate
        mainStoryboard = viewController.mainStoryboard
    }
}
