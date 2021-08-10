//
//  ImagePopOverVC.swift
//  Boxing 247
//
//  Created by Omar on 08/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit

class ImagePopOverVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    
    @IBOutlet weak var background: UIImageView!
    var screenshot: UIImage?
    
    @IBOutlet weak var imageViewCenter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if screenshot == nil {
            imageViewCenter.constant = imageViewCenter.constant - 200
        }

        imageView.image = image
        background.image = screenshot
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
        view.isUserInteractionEnabled = true
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
      }
}

