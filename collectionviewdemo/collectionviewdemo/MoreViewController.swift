//
//  MoreViewController.swift
//  collectionviewdemo
//
//  Created by Igor on 06.06.2022.
//

import UIKit

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func safariButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "More to Web", sender: "https://yandex.ru")
    }
    
    @IBAction func communityButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "More to Web", sender: "https://google.com")
    }
    
    @IBAction func twitterHandleTapped(_ sender: Any) {
        performSegue(withIdentifier: "More to Web", sender: "https://twitter.com/iigori")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "More to Web" {
            let toNav = segue.destination as! UINavigationController
            let toVC = toNav.viewControllers.first as! WebViewController
            toVC.urlString = sender as? String
        }
    }
}
