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
        //deleteOldNewsArticles()
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

    func deleteOldNewsArticles() {
        
        guard
            let oldNewsArticles = FetchUtility.news(fetch: .old)
        else {
            print("fetch failure")
            return
        }
        
        for news in oldNewsArticles {
            print("DELETING: \(news.title!)\n\(news.pubDate!)\n")
           _ = NewsArticle.eraseCurrent(news)
        }
        SaveUtility.saveChanges()
    }
}

//for familyName in UIFont.familyNames {
//    print(UIFont.fontNames(forFamilyName: familyName))
//}
