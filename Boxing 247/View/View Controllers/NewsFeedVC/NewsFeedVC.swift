//
//  NewsFeedVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit


class NewsFeedVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationPanelButton: UIBarButtonItem!
    var centerNavigationController: UINavigationController!
    var delegate: NewsFeedVCDelegate?
    let viewModel = NewsFeedVM()
    
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        delegate?.toggleLeftPanel?()
            //This uses optional chaining to only call toggleLeftPanel() if delegate has a value.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = dark247
        self.navigationBar.largeTitleDisplayMode = .always
        collectionView.register(UINib.init(nibName: "NewsFeedCell", bundle: nil), forCellWithReuseIdentifier: "tCell")

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
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let deviceSize = UIScreen.main.bounds.size
        let cellWidth = deviceSize.width - (2 * 12);
        
        // Calulates height of cell by adding the heights of all contained views in NewsFeedCell.xib
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! NewsFeedCell
        let cellViewModel = viewModel.cellVMArray[indexPath.row]
        
        let cellHeight =
            cell.heightForLable(text: cellViewModel.article.title, font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold), width: cellWidth, lines: 2) +
            cell.heightForLable(text: cellViewModel.article.content, font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.ultraLight), width: cellWidth , lines: 2) +
            cell.heightForLable(text: cellViewModel.article.author, font: UIFont.italicSystemFont(ofSize: 13), width: cellWidth, lines: 3) +
            cell.thumbnail.bounds.size.height + 3
        
        return CGSize(width: cellWidth , height: cellHeight)
    }
}


@objc
protocol NewsFeedVCDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanels()
}

// https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height/44352072
