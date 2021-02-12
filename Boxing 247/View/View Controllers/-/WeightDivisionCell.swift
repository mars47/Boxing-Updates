//
//  WeightDivisionCell.swift
//  Boxing 247
//
//  Created by Omar  on 01/08/2018.
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

class WeightDivisionCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView?
    
    var isExpanded = true
    var array = [1,2,3,4]
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.estimatedRowHeight = 52.5
        tableView?.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "federationCell")
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        tableView.safeAreaInsets = section == 0 ? UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0) : UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //isExpanded ? 4 : 0
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "federationCell", for: indexPath) as! TextCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
