//
//  NewsFeedVC.swift
//  Boxing 247
//
//  Created by Omar  on 30/06/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController {
    
    @IBOutlet weak var navigationPanelButton: UIBarButtonItem!
    var delegate: NewsFeedVCDelegate?

    @IBAction func navPanelButtonPressed(_ sender: Any) {
        delegate?.toggleLeftPanel?()
            //This uses optional chaining to only call toggleLeftPanel() if delegate has a value and it has implemented the method.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}


@objc
protocol NewsFeedVCDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanels()
}

extension NewsFeedVC: NavigationPanelVCDelegate {
    
    // This method simply populates the image view and labels in the center view controller with the animal’s image, title, and creator. Then, if the center view controller has a delegate of its own, you can tell it to collapse the side panel away so you can focus on the selected item.
    
    func didSelectAnimal() {
        //        imageView.image = animal.image
        //        titleLabel.text = animal.title
        //        creatorLabel.text = animal.creator
        //
        //        delegate?.collapseSidePanels?()
    }
}
