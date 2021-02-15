//
//  RankingsVC.swift
//  Boxing 247
//
//  Created by Omar on 10/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

class RankingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let viewModel = RankingsVM()
    enum Segment: Int {
        case weightDivision
        case federation
    }
        
    // MARK: - Configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        configureHeaderViews()
        viewModel.configureSectionStates()
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
    
    // MARK: - Events

    @IBAction func segmentedControlTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    @objc func expandCloseTapped(button: UIButton) {
        
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex)
        let identifier = segment == .weightDivision ? "WEIGHT_DIVISION_HEADER" : "FEDERATION_HEADER"
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as! WeightDivisionHeader
        
        header.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        header.button.addTarget(self, action: #selector(expandCloseTapped), for: .touchUpInside)
        header.button.tag = section
        header.configureButtonImage(isExpanded: viewModel.sectionStates[segment!.rawValue][section])
        
        DispatchQueue.main.async {
            
            header.configureShadowAndRoundCorners(shadowBounds: header.subviews[2])
            header is FederationHeader ? (header as! FederationHeader).roundClearPanelCorners() : Void()
        }

        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex)
        return segment == .weightDivision ? viewModel.banners.count : viewModel.belts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex) else { return 0 }
        
        let state = viewModel.sectionStates[segment.rawValue][section]
        return state ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let width = (UIScreen.main.bounds.size.width - 40) // 40 = inset
        return segmentedControl.selectedSegmentIndex == 0 ? width / 2.48 : width / 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 12 : UITableView.automaticDimension
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
}


