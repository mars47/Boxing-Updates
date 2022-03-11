//
//  BoxerProfileVC.swift
//  Boxing 247
//
//  Created by Omar on 11/03/2022.
//  Copyright © 2022 Omar. All rights reserved.
//

import UIKit

class BoxerProfileVC: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var beltContainerView: UIView!
    @IBOutlet weak var beltImageView: UIImageView!
    @IBOutlet weak var beltNameLabel: UILabel!
    @IBOutlet weak var beltAcquiredDateLabel: UILabel!
    
    var belt: Belt!
    var screenshot: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.sendSubviewToBack(background)
        configureViewController(with: belt)
        beltImageView.layer.cornerRadius = beltImageView.frame.height / 2
    }
    
    func configureViewController(with belt: Belt) {
        
        background.image = screenshot
        beltImageView.image = UIImage(systemName: "shield")
        beltImageView.tintColor = UIColor.systemYellow
        beltImageView.backgroundColor = UIColor.updateBeltColour(for: belt)
        
        beltImageView.layer.cornerRadius = 100
        beltImageView.clipsToBounds = true
        
        beltContainerView.roundedCorners(radius: 8)
        profileView.roundedCorners(radius: 8)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
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
