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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
      }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
