//
//  RankingsCell.swift
//
//
//  Created by Omar on 03/01/2020.
//  Copyright © 2020 Omar. All rights reserved.
//

import UIKit

class RankingsCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties

    /* This cell contains a tableview that hosts 4 text cells */
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var height: NSLayoutConstraint!

    var segment: RankingsVC.Segment! {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Configuration
    
    override func awakeFromNib() {
        super.awakeFromNib()

        tableView.delegate = self
        tableView.dataSource = self
        tableView?.estimatedRowHeight = 52.5
        tableView?.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "federationCell")
    }
    
    override func layoutSubviews() {
        
        configureShadowAndRoundCorners(shadowBounds: subviews[0], cornerRadius: nil)
        super.layoutSubviews()
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "federationCell", for: indexPath) as! TextCell
        cell.configureIcon(with: segment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
