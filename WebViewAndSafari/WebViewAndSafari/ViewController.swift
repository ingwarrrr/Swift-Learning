//
//  ViewController.swift
//  WebViewAndSafari
//
//  Created by Igor on 17.03.2022.
//

import UIKit
import WebKit
import SafariServices

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var addressUrlField: UITextField!
    
    let urlPrefix = "https://www."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func webViewPressed(_ sender: Any) {
        let url = urlPrefix + addressUrlField.text!
        
        let urlRequst = URLRequest(url: URL(string: url)!)
        webView.load(urlRequst)
    }
    
    @IBAction func safariPressed(_ sender: Any) {
        let url = urlPrefix + addressUrlField.text!
        
        let safariVC = SFSafariViewController(url: URL(string: url)!)
        present(safariVC, animated: true) {
            self.addressUrlField.text = ""
        }
    }
}

