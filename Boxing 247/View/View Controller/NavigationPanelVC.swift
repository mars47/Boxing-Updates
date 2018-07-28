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
    let pages : [String] = ["Fight Schedule", "Current Champions", "Weight Classes", "Community", "Saved Articles"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PanelCell", for: indexPath) as? PanelCell {
            cell.pageTitle.text = pages[indexPath.row]
            return cell
        }
            
        return UITableViewCell()
    }
}

