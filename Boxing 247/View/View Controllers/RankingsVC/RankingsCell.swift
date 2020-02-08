//
//  RankingsCell.swift
//
//
//  Created by Omar on 03/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

class RankingsCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var height: NSLayoutConstraint!

    var segment: Segment! {
        didSet {
            tableView.reloadData()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()

        tableView.delegate = self
        tableView.dataSource = self
        tableView?.estimatedRowHeight = 52.5
        tableView?.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "federationCell")
    }
    
    func updateHeight() {
        height.constant = tableView.contentSize.height
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "federationCell", for: indexPath) as! TextCell
        cell.configureIcon(segment: segment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func layoutSubviews() {
        configureShadowAndRoundCorners(shadowBounds: subviews[0])
        super.layoutSubviews()
    }
}
