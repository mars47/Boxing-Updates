//
//  WeightDivisionVC.swift
//  Boxing 247
//
//  Created by Omar  on 02/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var banners = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3"), UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3")]
    let belts = [UIImage(named: "wbo belt"), UIImage(named: "wba belt"), UIImage(named: "wbc belt")]
    let logos = [UIImage(named: "wbo logo"), UIImage(named: "wba logo"), UIImage(named: "wbc logo")]
    var sectionStates = [[Int]]()
    var isFirstRun = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = dark247

        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.register(UINib.init(nibName: "WeightDivisionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        let width = self.view.frame.size.width
        layout.headerReferenceSize = CGSize(width: width
            , height: (width / 5 ) + 55 )        
        for (index, _) in banners.enumerated() { sectionStates.append([index]) }
        //print("cellRef: \(sectionStates)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !isFirstRun {

        let indexPath = IndexPath(item: 0, section:  0)

        self.collectionView!.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: false)
            isFirstRun = true
        }
    }
        
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        
        //containerVC!.toggleLeftPanel!()
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        
        //collectionView?.reloadData()
    }
    
    // MARK -- CollectionView Delegate & Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return sectionStates[section].count == 0 ? 0 : 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionStates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DivisionCell", for: indexPath) as! WeightDivisionCell
        return cell
        
        
        //        if segmentedControl.selectedSegmentIndex == 0 {
        //            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! DivisionCell
        //            //            cell.thumbnail.image = weightArray[indexPath.row]
        //            //
        //            //            // cell.thumbnail.image = cell.thumbnail.image?.blurEffect(input: cell.thumbnail.image!)
        //            //            return cell
        //
        //        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let _cell = cell as! WeightDivisionCell
        _cell.height.constant = _cell.tableView!.contentSize.height
        _cell.width.constant = UIScreen.main.bounds.size.width - 40

        DispatchQueue.main.async {
            _cell.configureShadowAndRoundCorners(shadowBounds: _cell.contentView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {

        case UICollectionView.elementKindSectionHeader:

            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath as IndexPath) as! WeightDivisionReusableView

            headerView.configureShadowAndRoundCorners(shadowBounds: headerView.subviews[0])
            headerView.button.addTarget(self, action: #selector(handleExpansionClose), for: .touchUpInside)
            headerView.button.tag = indexPath.section
            return headerView

        default:  fatalError("Unexpected element kind")
        }
        
    }
    
    @objc func handleExpansionClose(button: UIButton) {
        
        let section = button.tag
        
        self.sectionStates[section].removeAll()
        
        UIView.performWithoutAnimation {
            self.collectionView?.deleteItems(at: [IndexPath(item: 0, section: section)])
        }
        
        // https://www.youtube.com/watch?v=Q8k9E1gQ_qg 10:53
    }
    
    
    

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return section == 0 ? UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0) : layout.sectionInset
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        segmentedControl.selectedSegmentIndex == 0 ? 2.5 : 14
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if segmentedControl.selectedSegmentIndex == 0 {
//            if indexPath.row == 0 {
//                let newVC = mainStoryboard.instantiateViewController(withIdentifier: "fighter") as? FighterVC
//                newVC?.delegate = containerVC
//                self.centerNavigationController?.pushViewController(newVC!, animated: true)
//                //delegate!.toggleLeftPanel?()
//            }
//        }
//    }
    
}


