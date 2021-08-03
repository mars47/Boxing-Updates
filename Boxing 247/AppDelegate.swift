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
        //window?.tintColor = UIColor(named: "pomegranate247")
        window?.backgroundColor = base247
    
        
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "AppleSDGothicNeo-UltraLight", size: 38.0)!, NSAttributedString.Key.foregroundColor: white247]
        
        
        // Set navigation bar tint / background colour
        UINavigationBar.appearance().backgroundColor = base247
        //UINavigationBar.appearance().barTintColor = dark247
        UINavigationBar.appearance().prefersLargeTitles = true
        //UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): white247]
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): white247]
        
        
        // Set navigation bar ItemButton tint colour
        //UIBarButtonItem.appearance().tintColor = UIColor(named: "pomegranate247")
        
        // Set Navigation bar background image
        //        let navBgImage:UIImage = UIImage(named: “bg_blog_navbar_reduced.jpg”)!
        //        UINavigationBar.appearance().setBackgroundImage(navBgImage, forBarMetrics: .Default)
        
        //Set navigation bar Back button tint colour
        //        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
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
    }
}

//for familyName in UIFont.familyNames {
//    print(UIFont.fontNames(forFamilyName: familyName))
//}
