//
//  NewsFeedVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NewsFeedVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties 

    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationPanelButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
    let viewModel = NewsFeedVM()
    let refreshControl = UIRefreshControl()
   
    enum Segment: Int {
        case latest
        case bookmarked
    }
    var segment : Segment {
        return Segment(rawValue: segmentedControl.selectedSegmentIndex)!
    }
    
    // MARK: - Configuration

    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureView()
        configureCollectionViewReload()
        viewModel.downloadNews(for:segment, completion: nil)
    }
    
    fileprivate func configureView() {
        
        collectionView.register(UINib.init(nibName: "NewsFeedCell", bundle: nil), forCellWithReuseIdentifier: "tCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl

        layout.minimumLineSpacing = 18.5
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        view.backgroundColor = dark247
        navigationController?.navigationBar.isTranslucent = true
    }

    fileprivate func configureCollectionViewReload() {
        
        viewModel.reloadCollectionView = { [self] in
            DispatchQueue.main.async {
                collectionView?.reloadData()
            }
        }
    }
    
    // MARK: - Events

    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        viewModel.fetchNewsArticles(for: segment)
    }

    @objc private func refreshNews(_ sender: Any) {
        
        viewModel.downloadNews(for: segment) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    func presentUIAlert(title: String, message: String, completion: ((Bool) -> Void)? ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = .label

        if completion == nil {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        } else {
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ handler in
                completion?(true)
            })
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: nil))
        }
        
        self.present(alert, animated: true, completion: nil)        
    }
    
    // MARK: - Collection view datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! NewsFeedCell
        let article = viewModel.newsArticles[indexPath.row]
        cell.configureCell(with: article)
        cell.presentUIAlert = { [self] title, message, completion in
            presentUIAlert(title: title, message: message, completion: completion)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let deviceSize = UIScreen.main.bounds.size
        let cellInsets = 2 * 20 as CGFloat
        let labelInsets = 16 * 2 as CGFloat
        let cellWidth = (deviceSize.width - cellInsets)
        
        /** Calculates height of cell by adding the heights of all views + spacing found in NewsFeedCell.xib */

        let article = viewModel.newsArticles[indexPath.row]
        let cellHeight =
                NewsFeedCell.calculateHeightForLabel(text: article.title ?? "", font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold), width: cellWidth - labelInsets, lines: 2)
                + 25 // button stackview
                + cellWidth / 5.63 // remaining space, dynamically calculated
        
        return CGSize(width: cellWidth , height: cellHeight)
    }
    
    // MARK: Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showNewsDetail", sender: nil)
        
        //guard let newsFeedDetailVC = storyboard?.instantiateViewController(withIdentifier: "NewsFeedDetail") as? NewsFeedDetailVC else { return }
        //self.centerNavigationController?.pushViewController(newsFeedDetailVC, animated: true)
    }
}
// https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height/44352072
