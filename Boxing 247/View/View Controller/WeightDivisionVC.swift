//
//  WeightDivisionVC.swift
//  Boxing 247
//
//  Created by Omar  on 02/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionVC: UIViewController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var collectionView: UICollectionView?
    var centerNavigationController: UINavigationController!
    var delegate: NewsFeedVCDelegate?
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        delegate!.toggleLeftPanel?()
    }
    let array = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3"), UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3")]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = dark247

        if let tableView = tableView {
        tableView.dataSource = self
        tableView.rowHeight = UIScreen.main.bounds.size.width / 4.498
        tableView.backgroundColor = dark247
        tableView.separatorColor = grey247
        tableView.tableFooterView = UIView()
        }
        
        if let collectionView = collectionView {
            
            collectionView.register(UINib.init(nibName: "DivisionCell", bundle: nil), forCellWithReuseIdentifier: "test")
            collectionView.register(UINib.init(nibName: "FederationCell", bundle: nil), forCellWithReuseIdentifier: "Federation")

            collectionView.dataSource = self
            collectionView.delegate = self
        }
        
    }
    
    @IBAction func segmentControlValueChanged(_ sender: CustomSegmentedControl) {
        collectionView?.reloadData()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "divisionCell") as! WeightDivisionCell
        cell.thumbnail.image = array[indexPath.row]
        cell.thumbnail.contentMode = .scaleAspectFill
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    // MARK -- CollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! DivisionCell
            cell.thumbnail.image = array[indexPath.row]
            
            // cell.thumbnail.image = cell.thumbnail.image?.blurEffect(input: cell.thumbnail.image!)
            return cell
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Federation", for: indexPath) as! FederationCell
           // cell.thumbnail.image = array[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentedControl.selectedSegmentIndex == 0 {
            let width  = self.view.frame.size.width
            let height = width / 4.498
            return CGSize(width: width, height: height)
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let width  = self.view.frame.size.width - 30
            let height = width / 2
            return CGSize(width: width, height: height)
        }
        
        return CGSize()
    }
}



