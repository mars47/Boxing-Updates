//
//  AppDelegate.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit
import Instabug


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        configureCrashReporter()
        configureGlobalUIAppearanceSettings()
        deleteOldNewsArticlesAfter5days()
        fetchAllData()
        return true
    }
    
    func configureCrashReporter() {
        Instabug.start(withToken: "4c964612828aa87d11f54c754458ca63", invocationEvents: [.shake, .screenshot])
    }
    
    func configureGlobalUIAppearanceSettings() {
        
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "AppleSDGothicNeo-UltraLight", size: 38.0)!, NSAttributedString.Key.foregroundColor: white247]
        UINavigationBar.appearance().backgroundColor = base247
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): white247]
        UIScrollView.appearance().indicatorStyle = .black
        window?.backgroundColor = base247
    }

    func deleteOldNewsArticlesAfter5days(pointInTime date: Date? = nil) {
        
        guard
            let oldNewsArticles = FetchUtility.news(fetch: .old, from: date)
        else {
            print("fetch failure")
            return
        }
        
        _ = oldNewsArticles.map({ print("DELETING: \($0.title!)\n\($0.pubDate!)\n") })
        NewsArticle.eraseCurrent(elements: Set(oldNewsArticles) )
        SaveUtility.saveChanges()
    }
    
    func fetchAllData() {
        
        guard
            let tab = self.window?.rootViewController as? UITabBarController,
            let nav = tab.viewControllers?[1] as? UINavigationController,
            let rankingsVC = nav.viewControllers.first as? RankingsVC
        else {
            return
        }
        
        
//        NetworkManager.downloadBoxingData { error in
//
//            rankingsVC.hideLoadingView()
//            rankingsVC.viewModel.isDownloadingData = false
//            rankingsVC.viewModel.fetchRankingData()
//            rankingsVC.viewModel.configureSectionStates()
//            rankingsVC.tableView.reloadData()
//        }
    }
}

//for familyName in UIFont.familyNames {
//    print(UIFont.fontNames(forFamilyName: familyName))
//}
