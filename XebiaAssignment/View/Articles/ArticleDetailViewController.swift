//
//  ArticleDetailViewController.swift
//  XebiaAssignment
//
//  Created by Siva Cherukuri on 01/04/19.
//  Copyright © 2019 xebia. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    var urlString: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        loadWebpage()
    }

}


extension ArticleDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished navigating to url")
        loadingView.stopAnimating()
    }
    
}

extension ArticleDetailViewController {
    fileprivate func setupViews() {
        webView.navigationDelegate = self
    }
    
    fileprivate func loadWebpage() {
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
    }
}
