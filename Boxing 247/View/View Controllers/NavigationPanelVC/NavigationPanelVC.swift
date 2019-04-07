//
//  NavigationPanelVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NavigationPanelVC: B247ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = NavigationPanelVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = dark247
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = test247
    }
    
    //MARK: TableView datasource & delegate
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.rows.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.rows[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PanelCell", for: indexPath) as? PanelCell else { return UITableViewCell() }
        
        cell.configureCell(with: viewModel, and: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        getViewControllerAndPush(for: indexPath)
    }
    
    //MARK: Class Functions
    
    fileprivate func getViewControllerAndPush(for indexPath: IndexPath) {
    
        let cellPosition : (Int, Int) = (indexPath.section, indexPath.row)
        var vc: B247ViewController?
        
        switch cellPosition {
        case (0,0):
            vc = mainStoryboard.instantiateViewController(withIdentifier: "NewsFeed") as! NewsFeedVC
            vc!.configureController(withProperties: self, isCenter: true)

//        case (0,1):
//            return mainStoryboard.instantiateViewController(withIdentifier: "NewsFeed") as! NewsFeedVC
//
//        case (0,0):
//            return mainStoryboard.instantiateViewController(withIdentifier: "NewsFeed") as! NewsFeedVC
       
        default:
            vc = mainStoryboard.instantiateViewController(withIdentifier: "Division") as! WeightDivisionVC
            vc!.configureController(withProperties: self, isCenter: true)
        }
        pushViewController(viewController: vc!)
    }
    
    func pushViewController(viewController: B247ViewController) {
        self.centerNavigationController?.pushViewController(viewController, animated: true)
        delegate!.toggleLeftPanel?()
    }
}


