//
//  NavigationPanelVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class NavigationPanelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: NavigationPanelVCDelegate?
    let sections =  ["Latest", "Boxing", "Community", "Help"]
    let array = [
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
        return array.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PanelCell", for: indexPath) as? PanelCell {
            
            cell.icon.image = icons[indexPath.section][indexPath.row]!
            cell.pageTitle.text = array[indexPath.section][indexPath.row]
            if indexPath.row != 0 {
                cell.topPanel.backgroundColor = cell.backgroundColor
            }
            
            else {
                cell.topPanel.backgroundColor = UIColor.lightGray
            }

            return cell
        }
        return UITableViewCell()
    }
}

