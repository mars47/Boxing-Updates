//
//  RankingsVM.swift
//  Boxing 247
//
//  Created by Omar  on 13/02/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import Foundation
import UIKit

protocol RankingsVCDelegate {
    
    func refreshTableView()
    func hideLoadingView()
}

enum States: Int {
    case open
    case closed
}

class RankingsVM {
    
    // MARK: - Properties

    var delegate : RankingsVCDelegate?
    var datasource = [Updatable]()
    var weightDivisions = [WeightClass]()
    var federations = [Organisation]()
    var isDownloadingData = true
    var selectedSegment: RankingsVC.Segment = .weightDivision
    
    var weightDivisionImages = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3"), UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight")]
    let federationImages = [UIImage(named: "wbo belt"), UIImage(named: "wba belt"), UIImage(named: "wbc belt")]
    let logos = [UIImage(named: "wbo logo"), UIImage(named: "wba logo"), UIImage(named: "wbc logo")]
    var sectionStates = [ [Bool](), [Bool]() ]
    //var states = [ [States](), [States]() ]
    
    // MARK: - Public Methods

    func configureSectionStates() {
        
        for _ in weightDivisionImages { sectionStates[0].append(true) }
        for _ in federationImages { sectionStates[1].append(true) }
        //for _ in weightDivisionImages { states[0].append(.open) }
    }
    
    func fetchRankingData() {
        
        if !isDownloadingData {
            weightDivisions = FetchUtility.weightClasses() ?? []
            federations = FetchUtility.organisations() ?? []
        }
    }
    
    func updateDatasource() {
        
        switch selectedSegment {
        case .federation:
            datasource = federations
        case .weightDivision:
            datasource = weightDivisions
        }
    }
}
