//
//  NewsFeedVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit


class NewsFeedVC: B247ViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationPanelButton: UIBarButtonItem!

    let viewModel = NewsFeedVM()
    let refreshControl = UIRefreshControl()
    
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        containerVC?.toggleLeftPanel?()
            //This uses optional chaining to only call toggleLeftPanel() if delegate has a value.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = dark247
        self.navigationBar.largeTitleDisplayMode = .always
        collectionView.register(UINib.init(nibName: "NewsFeedCell2", bundle: nil), forCellWithReuseIdentifier: "tCell")

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)

        bindViewModel()
        viewModel.downloadNews{}

    }
    
    func bindViewModel(){
        viewModel.articlesArray.bindAndFire() { [weak self] _ in
            DispatchQueue.main.async{
                self?.collectionView?.reloadData()
            }
        }
    }
    
    @objc private func refreshNews(_ sender: Any) {
        viewModel.downloadNews {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.refreshControl.endRefreshing()
            }
        }
    }

    //MARK: collectionView Delegate & Datasource -------
    
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
        let insets = (2 * 12) as CGFloat
        let cellWidth = deviceSize.width - insets;
        
        // Calulates height of cell by adding the heights of all views found in NewsFeedCell.xib
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! NewsFeedCell
        let cellViewModel = viewModel.cellVMArray[indexPath.row]
        
        let cellHeight =
            cell.calculateHeightForLable(text: cellViewModel.article.title, font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold), width: cellWidth, lines: 2) +
            cell.calculateHeightForLable(text: cellViewModel.article.content, font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.ultraLight), width: cellWidth , lines: 2) +
            cell.calculateHeightForLable(text: cellViewModel.article.author, font: UIFont.italicSystemFont(ofSize: 13), width: cellWidth, lines: 3) +
            cell.thumbnail.bounds.size.height + 3
        
        return CGSize(width: cellWidth , height: cellHeight)
    }
}
// https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height/44352072
