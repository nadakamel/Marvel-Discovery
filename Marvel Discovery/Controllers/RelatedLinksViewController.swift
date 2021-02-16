//
//  RelatedLinksViewController.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/7/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit
import WebKit

class RelatedLinksViewController: UIViewController, WKNavigationDelegate {

    var relatedLink : (type: String, url: String) = ("","")
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        
        self.title = relatedLink.type.capitalized
        webView.navigationDelegate = self
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! Internet is available.")
            if let url = URL(string: relatedLink.url) {
                let request = URLRequest(url: url)
                webView.load(request)
                webView.allowsBackForwardNavigationGestures = true
            }
        }
        else {
            print("No internet is available!")
            let alert = UIAlertController(title: "Error", message: "No internet connection.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = false
    }

}
