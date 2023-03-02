//
//  ImagePopOverVC.swift
//  Boxing 247
//
//  Created by Omar on 08/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit

class ImagePopOverVC: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewCenter: NSLayoutConstraint!
    
    var screenshot: UIImage?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        background.image = screenshot
        imageViewCenter.constant = screenshot == nil ? imageViewCenter.constant - 200 : imageViewCenter.constant
        
    
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
        view.isUserInteractionEnabled = true
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
      }
}
