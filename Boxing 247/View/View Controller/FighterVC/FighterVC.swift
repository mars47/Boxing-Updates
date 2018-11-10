//
//  FighterVC.swift
//  Boxing 247
//
//  Created by Omar  on 09/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class FighterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

     var delegate: NewsFeedVCDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fighter", for: indexPath)
        return cell
    }
}
