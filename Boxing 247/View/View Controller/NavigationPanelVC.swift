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
    let pages : [String] = ["News", "Fight Schedule", "Current Champions", "Weight Classes", "Community", "Dashboard", "Messages", "Polls", "Saved Articles", "Contact Us", "Settings"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = dark247
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = dark247

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PanelCell", for: indexPath) as? PanelCell {
            cell.pageTitle.text = pages[indexPath.row]
            cell.backgroundColor = dark247
            return cell
        }
            
        return UITableViewCell()
    }
}

