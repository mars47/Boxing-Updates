//
//  NavigationPanelVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NavigationPanelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var mainStoryboard: UIStoryboard!
    var centerNavigationController: UINavigationController!
    var containerVC: ContainerVC!
    var delegate: NewsFeedVCDelegate?

    let sections =  ["Latest", "Boxing", "Community", "Help"]
    let rows = [
        ["News", "Fight Schedule", "Saved Articles"],
        ["Current Champions", "Weight Divisions"],
        ["Dashboard", "Messages", "Polls"],
        ["Contact Us", "Settings"]
    ]
    let icons = [[UIImage(named:"newsIcon"), UIImage(named:"calenderIcon"), UIImage(named:"downloadIcon")], [UIImage(named:"champIcon"), UIImage(named:"divisionsIcon")], [UIImage(named:"dashboardIcon"), UIImage(named:"messageIcon"), UIImage(named:"pollIcon")], [UIImage(named:"contactIcon"), UIImage(named:"settingsIcon")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = dark247
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = test247

    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
//        if let tableViewHeaderFooterView = view as? UITableViewHeaderFooterView {
//            //tableViewHeaderFooterView.textLabel?.textColor = UIColor.red
//            //tableViewHeaderFooterView.textLabel?.text = "SECTION"
//            tableViewHeaderFooterView.backgroundColor = red247
//
//        }
//
//    }
    
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection: Int) -> CGFloat {
//        return 30
//    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rows[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PanelCell", for: indexPath) as? PanelCell {
            
            cell.icon.image = icons[indexPath.section][indexPath.row]!
            cell.pageTitle.text = rows[indexPath.section][indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let path = "path\([indexPath.section])\([indexPath.row])"

        if indexPath.row == 0 && indexPath.section == 0 {
            let newVC = mainStoryboard.instantiateViewController(withIdentifier: "tController") as? NewsFeedVC
            newVC?.delegate = containerVC
            newVC?.navigationBar.largeTitleDisplayMode = .never
            self.centerNavigationController?.pushViewController(newVC!, animated: true)
            delegate!.toggleLeftPanel?()
        } else {
       
        let newVC = mainStoryboard.instantiateViewController(withIdentifier: "Division") as? WeightDivisionVC
        newVC?.delegate = containerVC
        newVC?.mainStoryboard = mainStoryboard
        newVC?.centerNavigationController = centerNavigationController
        self.centerNavigationController?.pushViewController(newVC!, animated: true)
        delegate!.toggleLeftPanel?()
        }
    }
    
    func getViewController(for indexPath: IndexPath) -> UIViewController {
    
        let cellPosition : (Int, Int) = (indexPath.section, indexPath.row)
        
        switch cellPosition {
        case (0,0):
            return mainStoryboard.instantiateViewController(withIdentifier: "tController") as! NewsFeedVC
            
        case (0,0):
            return mainStoryboard.instantiateViewController(withIdentifier: "tController") as! NewsFeedVC
            
        case (0,0):
            return mainStoryboard.instantiateViewController(withIdentifier: "tController") as! NewsFeedVC
        default:
            return UIViewController()
        }
    }
}


