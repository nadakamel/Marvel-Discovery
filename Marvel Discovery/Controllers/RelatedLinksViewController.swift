//
//  RelatedLinksViewController.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/7/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import UIKit

class RelatedLinksViewController: UIViewController, UIWebViewDelegate {

    var relatedLink : (type: String, url: String) = ("","")
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        
        self.title = relatedLink.type.capitalized
        webView.delegate = self
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! Internet is available.")
            if let url = URL(string: relatedLink.url) {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        }
        else {
            print("No internet is available!")
            let alert = UIAlertController(title: "Error", message: "No internet connection.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
