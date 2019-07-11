//
//  247ViewController.swift
//  Boxing 247
//
//  Created by Omar  on 06/04/2019.
//  Copyright © 2019 Omar. All rights reserved.
//

import UIKit

/* Parent class for all custom View Controllers. Contains all the properties needed by any custom View controller so that the Navigation Panel can work  */

class B247ViewController: UIViewController {
    
    var centerNavigationController: UINavigationController!
    var delegate: NavigationPanelDelegate? // <-- Should always be instance of 'ContainerVC'
    var mainStoryboard: UIStoryboard!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureController(withProperties viewController: B247ViewController) -> B247ViewController {
        
        centerNavigationController = viewController.centerNavigationController
        delegate = viewController.delegate
        mainStoryboard = viewController.mainStoryboard
        return self
    }


}

