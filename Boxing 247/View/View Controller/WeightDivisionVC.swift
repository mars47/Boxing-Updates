//
//  WeightDivisionVC.swift
//  Boxing 247
//
//  Created by Omar  on 02/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionVC: UIViewController, UITableViewDataSource {
    var delegate: NewsFeedVCDelegate?
    @IBAction func navPanelButtonPressed(_ sender: Any) {
        delegate!.toggleLeftPanel?()
    }
    let array = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3")]
    var centerNavigationController: UINavigationController!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.rowHeight = UIScreen.main.bounds.size.width / 4.498
        tableView.backgroundColor = dark247
        tableView.separatorColor = grey247
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "divisionCell") as! WeightDivisionCell
        cell.thumbnail.image = array[indexPath.row]
        cell.thumbnail.contentMode = .scaleAspectFill
        //cell.thumbnail.clipsToBounds = true
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return array.count
    }
}
