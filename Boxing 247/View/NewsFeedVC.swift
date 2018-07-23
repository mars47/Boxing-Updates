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
    var delegate: NewsFeedVCDelegate?
    let appServerClient = AppServerClient()
    let viewModel = NewsFeedVM()
    var articles: [Article]?

    @IBAction func navPanelButtonPressed(_ sender: Any) {
        delegate?.toggleLeftPanel?()
            //This uses optional chaining to only call toggleLeftPanel() if delegate has a value and it has implemented the method.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.assignViewModel(viewModel: cellViewModel)
        return cell
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

