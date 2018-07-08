//
//  WebViewController.swift
//  ParseJSON
//
//  Created by Антон Зайцев on 21.06.2018.
//  Copyright © 2018 Антон Зайцев. All rights reserved.
//

import UIKit
import SafariServices

class WebViewController: UIViewController {

    var url: String?
    let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWebView()
    }
    
    func createWebView() {
        view.addSubview(webView)
        let webURL = URL(string: self.url!)
        let requestObj = URLRequest(url: webURL!)
        webView.loadRequest(requestObj)
        
        // Констрейнты
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
