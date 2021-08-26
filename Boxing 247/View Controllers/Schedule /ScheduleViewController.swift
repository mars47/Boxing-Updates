//
//  ScheduleViewController.swift
//  Boxing 247
//
//  Created by Omar on 23/08/2021.
//  Copyright © 2021 Omar. All rights reserved.
//

import UIKit
import WebKit

class ScheduleViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webview: WKWebView!
    let testView: LoadView = UIView.fromNib()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        testView.configureView(height: webview.frame.height)
        
        let url = URL(string:"https://box.live/upcoming-fights-schedule/") //http://fightnights.com/upcoming-boxing-schedule
        let request = URLRequest(url: url!)
        webview.navigationDelegate = self
        webview.addSubview(testView)
        webview.load(request)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        testView.isHidden = true
    }
}
