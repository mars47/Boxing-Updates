//
//  NewsFeedVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit


class NewsFeedVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationPanelButton: UIBarButtonItem!
    var centerNavigationController: UINavigationController!
    var delegate: NewsFeedVCDelegate?
    let viewModel = NewsFeedVM()


    @IBAction func navPanelButtonPressed(_ sender: Any) {
        delegate?.toggleLeftPanel?()
            //This uses optional chaining to only call toggleLeftPanel() if delegate has a value and it has implemented the method.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //centerNavigationController.navigationBar.prefersLargeTitles = true
        collectionView.register(UINib.init(nibName: "NewsFeedCell", bundle: nil), forCellWithReuseIdentifier: "tCell")
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1,height: 1)
        }
        collectionView.delegate = self
        collectionView.dataSource = self

        bindViewModel()
        viewModel.downloadNews()
    }
    
    func bindViewModel(){
        viewModel.articlesArray.bindAndFire() { [weak self] _ in
            DispatchQueue.main.async{
                self?.collectionView?.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.articlesArray.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! NewsFeedCell

        // Prepares viewModel for assignation to a collectionViewCell
        let cellViewModel = viewModel.cellVMArray[indexPath.row]
        cell.viewModel = cellViewModel
        cell.thumbnail.contentMode = .scaleAspectFit
        cell.thumbnail.clipsToBounds = true
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height/44352072
//        return CGSize()
//    }
    
}


@objc
protocol NewsFeedVCDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanels()
}

