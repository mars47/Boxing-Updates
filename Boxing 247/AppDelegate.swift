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
        
        self.window?.tintColor = UIColor(named: "pomegranate247")
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        let containerVC = ContainerVC()
//        self.window!.rootViewController = containerVC
//        self.window!.makeKeyAndVisible()
        
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "AppleSDGothicNeo-UltraLight", size: 38.0)!, NSAttributedString.Key.foregroundColor: white247]
        
        
        // Set navigation bar tint / background colour
        //UINavigationBar.appearance().
        UINavigationBar.appearance().backgroundColor = dark247
        //UINavigationBar.appearance().barTintColor = dark247
        UINavigationBar.appearance().prefersLargeTitles = true
        //UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): white247]
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): white247]
        
        
        // Set navigation bar ItemButton tint colour
        UIBarButtonItem.appearance().tintColor = red247
        
        // Set Navigation bar background image
        //        let navBgImage:UIImage = UIImage(named: “bg_blog_navbar_reduced.jpg”)!
        //        UINavigationBar.appearance().setBackgroundImage(navBgImage, forBarMetrics: .Default)
        
        //Set navigation bar Back button tint colour
        //        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//for familyName in UIFont.familyNames {
//    print(UIFont.fontNames(forFamilyName: familyName))
//}
