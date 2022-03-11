//
//  RankingsVC.swift
//  Boxing 247
//
//  Created by Omar on 10/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

class RankingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, RankingsVCDelegate {
    
    // MARK: - Properties

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var noInternetView : UIView!
    let loadView: LoadView = UIView.fromNib()
    let emptyDataSetView: EmptyDatasetView = UIView.fromNib()
    
    let viewModel = RankingsVM()
    enum Segment: Int {
        case weightDivision
        case federation
    }
    
    private var enterForegroundObserver: NSObjectProtocol?
    private var enterBackgroundObserver: NSObjectProtocol?
    var isNoInternetViewBeingPresented = false

        
    // MARK: - Configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        configureHeaderViews()
        configureLoadingView()
        configuredNotificationObservers()
        viewModel.configureSectionStates()
        viewModel.delegate = self 
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
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.clipsToBounds = false
    }

    fileprivate func configureHeaderViews() {
        tableView.register(UINib.init(nibName: "WeightDivisionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "WEIGHT_DIVISION_HEADER")
        tableView.register(UINib.init(nibName: "FederationHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "FEDERATION_HEADER")
    }
    
    fileprivate func configureLoadingView() {
        
        loadView.configureView(height: tableView.frame.height + 20)
        view.addSubview(loadView)
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
    
    // MARK: - Events

    @IBAction func segmentedControlTapped(_ sender: Any) {
        viewModel.selectedSegment = Segment(rawValue: segmentedControl.selectedSegmentIndex)!
        viewModel.updateDatasource()
        tableView.reloadData()
    }
    
    @objc func expandCloseButtonTapped(button: UIButton) {
        
        guard let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        let section = button.tag
        
        // close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        indexPaths.append(IndexPath(row: 0, section: section))
        indexPaths.append(IndexPath(row: 1, section: section))
        
        let isExpanded = viewModel.sectionStates[segment.rawValue][section]
        viewModel.sectionStates[segment.rawValue][section] = !isExpanded
        
        button.setImage(UIImage(systemName: isExpanded ? "plus.circle" : "minus.circle")!, for: .normal)
        
        isExpanded ? tableView.deleteRows(at: indexPaths, with: .fade) :
                     tableView.insertRows(at: indexPaths, with: .fade)
    }
    
    @objc func headerTapped(_ sender: UITapGestureRecognizer?) {
        guard let section = sender?.view?.tag else { return }

        performSegue(withIdentifier: "RankingsShowPopOverVC", sender: viewModel.datasource[section] as! WeightClass)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch true {
        case segue.identifier == "RankingsShowPopOverVC":
            guard
                let weightClass = sender as? WeightClass,
                let name = weightClass.name?.lowercased(),
                let viewController = segue.destination as? ImagePopOverVC
            else { return }
            
            viewController.image = UIImage(named: name + "_banner")
            viewController.screenshot = UIImage.takeScreenshot(view: self.view.window!)!
        
        case segue.identifier == "RankingsVCShowBoxerProfile":
            guard
                let belt = sender as? Belt,
                let viewController = segue.destination as? BoxerProfileVC
            else { return }

            viewController.belt = belt
            viewController.screenshot = UIImage.takeScreenshot(view: self.view.window!)!
            
        default:
            return
        }
        
    }
    
    // MARK: - RankingsVC delegate
    
    func hideLoadingView() {
        loadView.isHidden = true
    }
    
    func pushViewController(belt: Belt) {
        performSegue(withIdentifier: "RankingsVCShowBoxerProfile", sender: belt)
    }
    
    func presentNoInternetView() {
        
        if isNoInternetViewBeingPresented {
            return
        }
        
        isNoInternetViewBeingPresented = true
        let yPosition = tableView.frame.minY - CGFloat(14)
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

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if (indexPath.row == 0) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BLANK", for: indexPath)
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
            return cell
        }
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "RANKING_CELL", for: indexPath) as! RankingsCell
        cell.segment = Segment(rawValue: self.segmentedControl.selectedSegmentIndex)!
        cell.datasource = viewModel.belts(for:indexPath.section)
        cell.delegate = self
        
        viewModel.itemsScolledCount += 1
        viewModel.itemsScolledCount == 10 ? viewModel.handleItemsScrolled() : Void()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex)
        let identifier = segment == .weightDivision ? "WEIGHT_DIVISION_HEADER" : "FEDERATION_HEADER"
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as! WeightDivisionHeader
        
        if header is FederationHeader && !viewModel.datasource.isEmpty {
            let federation = (viewModel.datasource as? [Organisation])?[section]
            (header as! FederationHeader).configure(with: federation)
        }

        else if !(header is FederationHeader) && !viewModel.datasource.isEmpty {
            let weightclass = (viewModel.datasource as? [WeightClass])?[section]
            header.configure(with: weightclass)
        }
                
        header.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        header.button.addTarget(self, action: #selector(expandCloseButtonTapped), for: .touchUpInside)
        header.button.tag = section
        header.configureButtonImage(isExpanded: viewModel.sectionStates[segment!.rawValue][section])
        
        if viewModel.selectedSegment == .weightDivision {
            let tapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(headerTapped(_:)) )
            header.tag = section
            header.addGestureRecognizer(tapGestureRecognizer)
        }
        
        DispatchQueue.main.async {
            
            header.configureShadowAndRoundCorners(shadowBounds: header.subviews[2], cornerRadius: nil)
            header is FederationHeader ? (header as! FederationHeader).roundClearPanelCorners() : Void()
        }

        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
                
        emptyDataSetView.configure(with: "Unfortunately there has been a problem. Unable to find Rankings", image: UIImage(systemName: "exclamationmark.bubble.fill")!)
        let isEmptyDataSetEnabled = !viewModel.isDownloadingData && viewModel.datasource.count == 0
        
        tableView.backgroundView = isEmptyDataSetEnabled ? emptyDataSetView : nil
        
        return viewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex) else { return 0 }
        
        let isSectionExpanded = viewModel.sectionStates[segment.rawValue][section]
        return isSectionExpanded ? 2 : 0 // displays 2 cells. 'blank' cell (UI hack) + ranking cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let insets: CGFloat = 20 * 2
        let width = (UIScreen.main.bounds.size.width - insets)
        return segmentedControl.selectedSegmentIndex == 0 ? (width / 2.48) : (width / 2)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 12 : viewModel.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.alpha = 0.0
        return view
    }
    
     // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            let _cell = cell as! RankingsCell
            
            DispatchQueue.main.async {
                _cell.layoutSubviews()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("true")
    }
}


