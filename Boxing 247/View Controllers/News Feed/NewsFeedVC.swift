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
    let loadView: LoadView = UIView.fromNib()
    let emptyDataSetView: EmptyDatasetView = UIView.fromNib()
    
    private var enterForegroundObserver: NSObjectProtocol?
    private var enterBackgroundObserver: NSObjectProtocol?
    
    let viewModel = NewsFeedVM()
    let refreshControl = UIRefreshControl()
    enum Segment: Int {
        case latestNews
        case bookmarked
    }
    var selectedSegment : Segment {
        return Segment(rawValue: segmentedControl.selectedSegmentIndex)!
    }
    
    var isNoInternetViewBeingPresented = false
    var isLongPressActivated = true
    
    // MARK: - Configuration
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        configureViewModelCallBacks()
        configuredNotificationObservers()
        configureLoadingView()
        configureLongPressGesture()
        viewModel.downloadNews(for:selectedSegment, completion: nil)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.reloadCollectionView?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !viewModel.isInternetConnectionConnected {
            presentNoInternetView()
        }
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
        moreNewsButton.roundedCorners(radius: 16)
    }
    
    fileprivate func configureViewModelCallBacks() {
        
        viewModel.reloadCollectionView = { [self] in
            DispatchQueue.main.async {
                collectionView?.reloadData()
            }
        }
        
        viewModel.hideLoadingView = { [self] in
            DispatchQueue.main.async {
                loadView.isHidden = true
            }
        }
        
        viewModel.presentNoInternetView = { [self] in
            presentNoInternetView()
        }
        
        viewModel.presentErrorAlert = { [self] error in
            
            var message: String!
            
            if error is CustomError {
                message = (error as! CustomError).errorDescription
            } else {
                message = error.localizedDescription
            }
            
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        viewModel.scrollCollectionView = { [self] in
            DispatchQueue.main.async {
                let offset = viewModel.collectionViewScrollOffset
                let lastItem = collectionView(collectionView, numberOfItemsInSection: 0) - 1
                let indexpath = IndexPath(row: lastItem - offset, section: 0)
                collectionView.scrollToItem(at: indexpath, at: .centeredVertically, animated: true)
            }
        }
    }
    
    fileprivate func configuredNotificationObservers() {
        
        enterForegroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] notification in
            
            if !viewModel.isInternetConnectionConnected {
                presentNoInternetView()
            }
        }
        
        enterBackgroundObserver = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [unowned self] notification in
            
            noInternetView?.removeFromSuperview()
        }
        
    }
    
    fileprivate func configureLoadingView() {
        
        loadView.configureView(height: collectionView.frame.height + 20)
        view.addSubview(loadView)
    }
    
    fileprivate func configureLongPressGesture() {
        
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        collectionView.addGestureRecognizer(tap)
        collectionView.isUserInteractionEnabled = true
    }
    // MARK: - Events
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        
        func _switchAndReloadDatasource() {
            
            viewModel.switchDatasource(for: selectedSegment, indexPath: indexPath)
            viewModel.storeContentsSizeHeight(collectionView.contentSize.height, selectedSegment: selectedSegment)
            
            DispatchQueue.main.async { [self] in
                
                collectionView.reloadData()
                
                if viewModel.datasource.count == 0 { return }
                
                switch selectedSegment {
                
                case .latestNews:
                    collectionView.scrollToItem(at: viewModel.snapshotForSegmentLatest?.1 ?? IndexPath(row: 0, section: 0), at: .top, animated: false)
                    moreNewsButton.isHidden = collectionView.isAtBottom(using: viewModel.latestSegementContentHeight) ? false : true

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
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
       
        Vibration.success.vibrate()

        if sender.state == .began  {
            sender.isEnabled = false
            isLongPressActivated = true
        }
        
        let touchPoint = sender.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint) else { return }
        performSegue(withIdentifier: "NewsFeedShowPopOverVC", sender: viewModel.datasource[indexPath.row])
        sender.isEnabled = true
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
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch true  {
        
        case segue.identifier == "NewsFeedShowPopOverVC":
            guard
                let article = sender as? NewsArticle,
                let imageData = article.thumbnail,
                let viewController = segue.destination as? ImagePopOverVC
            else { return }
            viewController.image = UIImage(data: imageData)
            viewController.screenshot = UIImage.takeScreenshot(view: self.view.window!)!
                
        default:
            guard
                let article = sender as? NewsArticle,
                let viewController = segue.destination as? NewsFeedDetailVC
            else { return }
            viewController.newsArticle = article
            viewController.updateViewModel = { [self] in
                viewModel.updateDatasourceBookmarkRemoved()
                viewModel.reloadCollectionView?()
            }
            viewController.selectedSegment = selectedSegment
        }
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
        view.insertSubview(noInternetView, belowSubview: segmentedControl)
        
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
                                        isNoInternetViewBeingPresented = false
                                       })
                       }
        )
    }
    
    // MARK: - Collection view datasource
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let text = viewModel.getEmptyDatasetText(for: selectedSegment)
        emptyDataSetView.configure(with: text.0, image: UIImage(systemName: text.1)!)
        
        collectionView.backgroundView = (!viewModel.isDownloadingData && viewModel.datasource.count == 0) ? emptyDataSetView : nil
        
        return viewModel.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! NewsFeedCell
        let article = viewModel.datasource[indexPath.row]
        
        cell.configureCell(with: article)
        cell.presentUIAlert = { [self] title, message, completion in
            presentUIAlert(title: title, message: message, completion: completion)
        }
        cell.presentShareController = {
            let activityVC = UIActivityViewController(activityItems: ["Check out this free app called 'Boxing Updates' to keep updated with the latest boxing news!"], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        cell.presentImagePopoverController = { _ in
            self.performSegue(withIdentifier: "NewsFeedShowPopOverVC", sender: article)
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
    
    // MARK: - Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isLongPressActivated {
            isLongPressActivated = false
            return
        }
        
        let article = selectedSegment == .latestNews ?
            viewModel.newsArticles[indexPath.row] :
            viewModel.bookmarkedNewsArticles[indexPath.row]
        
        performSegue(withIdentifier: "showNewsDetail", sender: article)
    }
    
    // MARK: - Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if selectedSegment == .bookmarked {
            moreNewsButton.isHidden = true
            return
        }
        
        let isMoreItemsInDatasource = !viewModel.isAllItemsFetched && scrollView.isAtBottom
        moreNewsButton.isHidden = isMoreItemsInDatasource ? false : true
    }
}

// https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height/44352072

