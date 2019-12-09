//
//  WeightDivisionVC.swift
//  Boxing 247
//
//  Created by Omar  on 02/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionVC: B247ViewController, UITableViewDataSource, UICollectionViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var collectionView: UICollectionView?
    
    let banners = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3"), UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3")]
    
    let belts = [UIImage(named: "wbo belt"), UIImage(named: "wba belt"), UIImage(named: "wbc belt")]
    let logos = [UIImage(named: "wbo logo"), UIImage(named: "wba logo"), UIImage(named: "wbc logo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorColor = dark247
        tableView?.tableFooterView = UIView()
        tableView?.estimatedSectionHeaderHeight = 200
        tableView?.register(UINib.init(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "federationCell")
        
        //        if let collectionView = collectionView {
        //
        //            collectionView.register(UINib.init(nibName: "DivisionCell", bundle: nil), forCellWithReuseIdentifier: "test")
        //            collectionView.register(UINib.init(nibName: "FederationCell", bundle: nil), forCellWithReuseIdentifier: "Federation")
        //
        //            collectionView.dataSource = self
        //            collectionView.delegate = self
        //            collectionView.backgroundColor = view.backgroundColor
        //        }
    }
    
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        
        //containerVC!.toggleLeftPanel!()
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        //collectionView?.reloadData()
    }
    
    // MARK -- TableView Delegate & Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        banners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "federationCell") as! TextCell
        
        //cell.layer.cornerRadius = 10
        //cell.layer.addShadow()
        
//        if indexPath.row == 0 {
//            cell.configureCellType(type: .top)
//        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1  {
//            cell.configureCellType(type: .bottom)
//        } else {
//            cell.configureCellType(type: .middle)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            let banner: WeightDivisionBanner = .fromNib()
            banner.thumbnail.image = banners[section]
            banner.clipsToBounds = true
            return banner
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            
            let view: FederationView = .fromNib()
            view.backgroundImage.image = logos[section]
            view.layer.cornerRadius = 12.0
            view.clipsToBounds = true
            return view
        }
        
        return nil
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
//
//            cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 12)
//            cell.layer.cornerRadius = 10
//            cell.layer.masksToBounds = false
//            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
//
//        } else {
//
//            //cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 0)
//            cell.layer.masksToBounds = false
//            cell.separatorInset = UIEdgeInsets(top: 0, left: 65, bottom: 0, right: 30)
//        }
//
////        tableView.layer.masksToBounds = true
////        let radius = tableView.layer.cornerRadius
////        tableView.layer.shadowPath = UIBezierPath(roundedRect: tableView.bounds, cornerRadius: radius).cgPath
//    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let width  = self.view.frame.size.width
        return (width / 4.498 ) + 60
    }
    
    
    
    
    
    
    
    // MARK -- CollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        segmentedControl.selectedSegmentIndex == 0 ? banners.count : belts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! DivisionCell
            //            cell.thumbnail.image = weightArray[indexPath.row]
            //
            //            // cell.thumbnail.image = cell.thumbnail.image?.blurEffect(input: cell.thumbnail.image!)
            //            return cell
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Federation", for: indexPath) as! FederationCell
            //           // cell.thumbnail.image = array[indexPath.row]
            //            cell.backgroundImage.image = federationArray[indexPath.row]
            //            cell.icon.image = icons[indexPath.row]
            //            return cell
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
    
    private func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath as IndexPath)
        
        headerView.frame.size.height = 100
        
        return UIView() as! UICollectionReusableView
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        segmentedControl.selectedSegmentIndex == 0 ? 2.5 : 14
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




