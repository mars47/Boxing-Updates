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
    let loadView: LoadView = UIView.fromNib()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        loadView.configureView(height: webview.frame.height)
        
        webview.navigationDelegate = self
        webview.addSubview(loadView)
        
        guard let url = URL(string:"https://box.live/upcoming-fights-schedule/") else { return }
        webview.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        loadView.isHidden = true
    }
}
