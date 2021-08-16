//
//  AppDelegate.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //deleteOldNewsArticles()
        
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "AppleSDGothicNeo-UltraLight", size: 38.0)!, NSAttributedString.Key.foregroundColor: white247]
        UINavigationBar.appearance().backgroundColor = base247
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): white247]
        window?.backgroundColor = base247
       
        return true
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
