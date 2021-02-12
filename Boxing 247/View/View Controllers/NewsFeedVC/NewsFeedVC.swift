//
//  NewsFeedVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationPanelButton: UIBarButtonItem!

    let viewModel = NewsFeedVM()
    let refreshControl = UIRefreshControl()
    
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = dark247
        
        collectionView.register(UINib.init(nibName: "NewsFeedCell4", bundle: nil), forCellWithReuseIdentifier: "tCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.minimumLineSpacing = 18.5
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        
        self.navigationController?.navigationBar.isTranslucent = true

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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.refreshControl.endRefreshing()
            }
        }
    }

    // MARK: - collectionView Delegate & Datasource -------
    
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
        let cellInsets = 2 * 20 as CGFloat
        let labelInsets = 16 * 2 as CGFloat
        let cellWidth = (deviceSize.width - cellInsets)
        
        // Calulates height of cell by adding the heights of all views + spacing found in NewsFeedCell.xib
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! NewsFeedCell
        let cellViewModel = viewModel.cellVMArray[indexPath.row]
        let cellHeight =
            
                cell.calculateHeightForLable(text: cellViewModel.article.title, font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold), width: cellWidth - labelInsets, lines: 2)
                //+ cell.calculateHeightForLable(text: cellViewModel.article.author, font: UIFont.italicSystemFont(ofSize: 13), width: cellWidth - labelInsets, lines: 1)
                + 25 // button stackview
                + cellWidth / 5.63 
                //+ cell.thumbnail.bounds.size.height
                //+ 16 // stackview subview spacing
                //+ 12 // top+bottom stackview space
        
        return CGSize(width: cellWidth , height: cellHeight)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showNewsDetail", sender: nil)
        
        //guard let newsFeedDetailVC = storyboard?.instantiateViewController(withIdentifier: "NewsFeedDetail") as? NewsFeedDetailVC else { return }
        //self.centerNavigationController?.pushViewController(newsFeedDetailVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
// https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height/44352072
