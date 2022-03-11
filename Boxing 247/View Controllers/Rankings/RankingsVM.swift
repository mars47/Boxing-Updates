//
//  RankingsVM.swift
//  Boxing 247
//
//  Created by Omar  on 13/02/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import Foundation
import UIKit

class RankingsVM {
    
    // MARK: - Properties

    var delegate : RankingsVCDelegate?
    var datasource = [Updatable]()
    var weightDivisions = [WeightClass]()
    var federations = [Organisation]()
    var isDownloadingData = true
    var selectedSegment: RankingsVC.Segment = .weightDivision
    var isInternetConnectionConnected : Bool {
        ConnectionManager.shared.hasConnectivity()
    }
    var itemsScolledCount = 0

    var cellHeight : CGFloat  {
        switch selectedSegment {
        case .weightDivision:
            return TextCell.height * CGFloat(federations.count)
        case .federation:
            return TextCell.height * CGFloat(weightDivisions.count)
        }
    }
    
    var weightDivisionImages = [UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight"), UIImage(named: "middleweight3"), UIImage(named: "heavyweight5"), UIImage(named: "cruiserweight3"), UIImage(named: "lightheavyweight2"), UIImage(named: "supermiddleweight")]
    let federationImages = [UIImage(named: "wbo belt"), UIImage(named: "wba belt"), UIImage(named: "wbc belt")]
    let logos = [UIImage(named: "wbo logo"), UIImage(named: "wba logo"), UIImage(named: "wbc logo")]
    var sectionStates = [ [Bool](), [Bool]() ]
    //var states = [ [States](), [States]() ]
    
    // MARK: - Public Methods

    func configureSectionStates() {
        
        for _ in weightDivisions { sectionStates[0].append(true) }
        for _ in federations { sectionStates[1].append(false) }
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
        case .weightDivision:
            datasource = weightDivisions
        case .federation:
            datasource = federations
        }
    }
    
    func belts(for section: Int) -> [Belt] {
        
        switch selectedSegment {
            
        case .weightDivision:
            let belts = (datasource as! [WeightClass])[section].beltSet
            return belts.sorted(by: { $0.organisation!.identifierInt < $1.organisation!.identifierInt })
       
        case .federation:
            let belts = (datasource as! [Organisation])[section].beltSet
            return belts.sorted(by: { $0.weightClass!.lb!.intValue > $1.weightClass!.lb!.intValue })
        }
    }
    
    func handleItemsScrolled() {
        
        if !isInternetConnectionConnected {
            delegate?.presentNoInternetView()
        }
        
        itemsScolledCount = 0
    }
}

protocol RankingsVCDelegate {
    
    func hideLoadingView()
    func presentNoInternetView()
    func pushViewController(belt: Belt)
}

extension RankingsVCDelegate {
    func pushViewController(belt: Belt){}
}

enum States: Int {
    case open
    case closed
}
