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
    @IBOutlet weak var moreNewsButton: UIButton!
    var noInternetView : UIView!
    
    private var enterForegroundObserver: NSObjectProtocol?
    private var enterBackgroundObserver: NSObjectProtocol?

    let viewModel = NewsFeedVM()
    let refreshControl = UIRefreshControl()
    enum Segment: Int {
        case latest
        case bookmarked
    }
    var selectedSegment : Segment {
        return Segment(rawValue: segmentedControl.selectedSegmentIndex)!
    }
    
    var isNoInternetViewBeingPresented = false
    
    // MARK: - Configuration
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        configureViewModelCallBacks()
        configuredNotificationObservers()
        viewModel.downloadNews(for:selectedSegment, completion: nil)
    }
    
        override func viewDidAppear(_ animated: Bool) {
        
       // if !viewModel.isInternetConnectionEnabled {
            presentNoInternetView()
       // }
    }
    
    deinit {
        if let enterBackgroundObserver = enterBackgroundObserver {
            NotificationCenter.default.removeObserver(enterBackgroundObserver)
        }
        
        if let enterForegroundObserver = enterForegroundObserver {
            NotificationCenter.default.removeObserver(enterForegroundObserver)
        }
    }
    
    fileprivate func configureCollectionView() {
        
        collectionView.register(UINib.init(nibName: "NewsFeedCell", bundle: nil), forCellWithReuseIdentifier: "tCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        layout.minimumLineSpacing = 18.5
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
    }
    
    fileprivate func configureViewModelCallBacks() {
        
        viewModel.reloadCollectionView = { [self] in
            DispatchQueue.main.async {
                collectionView?.reloadData()
            }
        }
                
        viewModel.scrollCollectionView = { [self] in
            DispatchQueue.main.async {
                let offset = viewModel.collectionViewScrollOffset
                let lastItem = collectionView(collectionView, numberOfItemsInSection: 0) - 1
                let indexpath = IndexPath(row: lastItem - offset, section: 0)
                collectionView.scrollToItem(at: indexpath, at: .centeredVertically, animated: true)
            }
        }
        
        viewModel.presentNoInternetView = { [self] in
            presentNoInternetView()
        }
    }
    
    fileprivate func configuredNotificationObservers() {
        
        enterForegroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            
            if (view.subviews[1] is UICollectionView) {
                view.insertSubview( UIView(), at: 1)
            }
            
            if viewModel.isInternetConnectionEnabled {
                presentNoInternetView()
            }
        }
        
        enterBackgroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [unowned self] notification in
            
            noInternetView?.removeFromSuperview()
        }

    }
    
    // MARK: - Events

    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        func _switchAndReloadDatasource() {
            
            viewModel.switchDatasource(for: selectedSegment, indexPath: indexPath)
            viewModel.reloadCollectionView?()
            
            DispatchQueue.main.async { [self] in
                
                if viewModel.datasource.count == 0 { return }
                
                switch selectedSegment {
                
                case .latest:
                    collectionView.scrollToItem(at: viewModel.snapshotForSegmentLatest?.1 ?? IndexPath(row: 0, section: 0), at: .top, animated: false)
                    
                case .bookmarked:
                    collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredVertically, animated: false)
                }
            }
        }
        
        var indexPath : IndexPath?
        
        if selectedSegment == .bookmarked  {

            moreNewsButton.isHidden = true
            
            guard
                let cell = collectionView.visibleCells.first,
                let indexpath = collectionView.indexPath(for: cell)
            else { _switchAndReloadDatasource(); return }
            indexPath = indexpath
        }
        
        _switchAndReloadDatasource()
    }
    
    @IBAction func moreButtonPressed(_ sender: Any) {
        
        let itemCount = collectionView.numberOfItems(inSection: 0)
        viewModel.updateDatasource(for: selectedSegment, itemsDisplayedCount: itemCount)
        viewModel.reloadCollectionView?()
        viewModel.scrollCollectionView?()
    }
    
    @objc private func refreshNews(_ sender: Any) {
        
        viewModel.downloadNews(for: selectedSegment) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard
            let article = sender as? NewsArticle,
            let viewController = segue.destination as? NewsFeedDetailVC
        else { return }
        
        viewController.newsArticle = article
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
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) { [self] handler in
                completion?(false)
                
                if selectedSegment == .bookmarked {
                    viewModel.updateDatasourceBookmarkRemoved()
                    viewModel.reloadCollectionView?()
                }
            })
        }
        
        self.present(alert, animated: true, completion: nil)        
    }
    
    func presentNoInternetView() {
        
        if isNoInternetViewBeingPresented {
            return
        }

        isNoInternetViewBeingPresented = true
        let yPosition = collectionView.frame.minY - CGFloat(50)
        noInternetView = UIView().noInternetView(yPosition: yPosition)
        view.addSubview(noInternetView)
        view.bringSubviewToFront(self.segmentedControl)
        UIView.animate(withDuration: 0.2, delay: 0, options: [],
                          
                       animations: { [self] in
                            noInternetView.center.y += 55
                          },
                          
                          completion: { _ in
                            
                            UIView.animate(withDuration: 0.2, delay: 3, options: [],
                            
                                animations: { [self] in
                                noInternetView.center.y -= 55
                                },
                                
                                completion: { [self] _ in
                                
                                noInternetView.removeFromSuperview()
                                view.sendSubviewToBack(segmentedControl)
                                view.bringSubviewToFront(moreNewsButton)
                                isNoInternetViewBeingPresented = false
                            })
                          }
        )
    }
    
    // MARK: - Collection view datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! NewsFeedCell
        let article = viewModel.datasource[indexPath.row]
                
        cell.configureCell(with: article)
        cell.presentUIAlert = { [self] title, message, completion in
            presentUIAlert(title: title, message: message, completion: completion)
        }
        viewModel.itemsScolledCount += 1
        viewModel.itemsScolledCount == 20 ? viewModel.handleItemsScrolled() : Void()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellInsets = 2 * 20 as CGFloat
        let cellWidth = (deviceWidth - cellInsets)
        let labelInsets = 16 * 2 as CGFloat
        
        /** Calculates height of cell by adding the heights of all views + spacing found in NewsFeedCell.xib */

        let article = viewModel.datasource[indexPath.row]
        let cellHeight =
                NewsFeedCell.calculateHeightForLabel(text: article.title ?? "", font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold), width: cellWidth - labelInsets, lines: 2)
                + 25 // button stackview
                + cellWidth / 5.63 // remaining space, dynamically calculated
        
        return CGSize(width: cellWidth , height: cellHeight)
    }
    
    // MARK: Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            
        let islastCellDisplayed = (indexPath.row == viewModel.datasource.count - 1) && (selectedSegment == .latest)
        
        moreNewsButton.isHidden = islastCellDisplayed ? false : true
        
        if islastCellDisplayed && viewModel.allItemsFetched {
            moreNewsButton.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //for a in viewModel.newsArticles {print("\(a.pubDate)  \(a.title)\n")}
        let article = viewModel.newsArticles[indexPath.row]
        performSegue(withIdentifier: "showNewsDetail", sender: article)
        
        //guard let newsFeedDetailVC = storyboard?.instantiateViewController(withIdentifier: "NewsFeedDetail") as? NewsFeedDetailVC else { return }
        //self.centerNavigationController?.pushViewController(newsFeedDetailVC, animated: true)
    }
}
// https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height/44352072
