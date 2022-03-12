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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var belt: Belt!
    var screenshot: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController(with: belt)
    }
    
    func configureViewController(with belt: Belt) {
        
        spinner.isHidden = belt.boxer?.thumbnail == nil ? false : true
        background.image = screenshot
        
        beltImageView.image = UIImage(systemName: "shield")
        beltImageView.tintColor = UIColor.systemYellow
        beltImageView.backgroundColor = UIColor.updateBeltColour(for: belt)
        beltImageView.layer.cornerRadius = beltImageView.frame.height / 2

        if belt.boxer?.thumbnail == nil {
            downloadThumbnail()
        } else {
            thumbnailImageView.image = UIImage(data: belt.boxer!.thumbnail!)
        }
        
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.borderWidth = 1
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        nameLabel.text = belt.boxer?.name
        beltNameLabel.text = belt.name
        
        flagImageView.image = UIImage(named: belt.boxer?.country?.isoCode ?? "") ?? UIImage(named: "placeholder.jpg")
        countryLabel.text = belt.boxer?.country?.name
        
        beltContainerView.roundedCorners(radius: 8)
        profileView.roundedCorners(radius: 8)
        
        let dateFormatter = DateFormatter()   
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let calender = Calendar.current
        guard let beltAcquiredDaysAgo = calender.dateComponents([.day], from: belt.acquiredDate!, to: Date()).day else { return }
        let dateString = dateFormatter.string(from: belt.acquiredDate!)
        
        guard let years = calender.dateComponents([.year], from: belt.boxer!.dateOfBirth!, to: Date()).year else { return }
        
        ageLabel.text = "\(years) years old"
        beltAcquiredDateLabel.text = "\(dateString) (\(beltAcquiredDaysAgo) days)"
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
        view.isUserInteractionEnabled = true
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
      }
    
    fileprivate func downloadThumbnail() {
        
        NetworkManager.downloadThumbnailImage(for: URL(string: (belt.boxer?.thumbnailUrl)!)!) { [self] image in
            
            belt.boxer?.setImage(image: image)
            SaveUtility.saveChanges()
            thumbnailImageView.image = image ?? UIImage(named: "placeholder")!
            spinner.isHidden = true
        }
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
