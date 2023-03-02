//
//  EmptyDatasetView.swift
//  Boxing 247
//
//  Created by Omar on 06/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit

class EmptyDatasetView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func configure(with message: String, image: UIImage) {
        
        label.text = message
        imageView.image = image
    }
}
