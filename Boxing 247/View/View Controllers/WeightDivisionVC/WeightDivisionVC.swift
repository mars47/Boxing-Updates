//
//  WeightDivisionVC.swift
//  Boxing 247
//
//  Created by Omar  on 02/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionVC: B247ViewController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var collectionView: UICollectionView?
//    var delegate: NewsFeedVCDelegate?
//
//    var mainStoryboard: UIStoryboard!
//    var centerNavigationController: UINavigationController!
//    var containerVC: ContainerVC!
    
    
    
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        containerVC!.toggleLeftPanel?()
    }
    
    let weightArray = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3"), UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3")]
    
    
    let federationArray = [UIImage(named: "wbo belt"), UIImage(named: "wba belt"), UIImage(named: "wbc belt")]
    
    let icons = [UIImage(named: "wbo logo"), UIImage(named: "wba logo"), UIImage(named: "wbc logo")]

    

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
            collectionView.backgroundColor = view.backgroundColor
        }
    }

    
    @IBAction func segmentControlValueChanged(_ sender: CustomSegmentedControl) {
        collectionView?.reloadData()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "divisionCell") as! WeightDivisionCell
        cell.thumbnail.image = weightArray[indexPath.row]
        cell.thumbnail.contentMode = .scaleAspectFill
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightArray.count
    }
    
    // MARK -- CollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
        return weightArray.count
        } else { return federationArray.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! DivisionCell
            cell.thumbnail.image = weightArray[indexPath.row]
            
            // cell.thumbnail.image = cell.thumbnail.image?.blurEffect(input: cell.thumbnail.image!)
            return cell
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Federation", for: indexPath) as! FederationCell
           // cell.thumbnail.image = array[indexPath.row]
            cell.backgroundImage.image = federationArray[indexPath.row]
            cell.icon.image = icons[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentedControl.selectedSegmentIndex == 0 {
            let width  = self.view.frame.size.width
            let height = (width  / 4.498 )
            return CGSize(width: width, height: height)
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            let width  = self.view.frame.size.width - 30
            let height = width / 2
            return CGSize(width: width, height: height)
        }
        
        return CGSize()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 0 { return 2.5 } else { return 14 }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            if indexPath.row == 0 {
                let newVC = mainStoryboard.instantiateViewController(withIdentifier: "fighter") as? FighterVC
                newVC?.delegate = containerVC
                self.centerNavigationController?.pushViewController(newVC!, animated: true)
                //delegate!.toggleLeftPanel?()
        }
    }
}

}




