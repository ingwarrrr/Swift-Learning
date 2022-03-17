//
//  ViewController.swift
//  CustomCellTableView
//
//  Created by Igor on 17.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var countries = ["Japan",
                     "China",
                     "UK",
                     "Germany",
                     "Spain",
                     "USA",
                     "France"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // datasource
        tableView.dataSource = self
        tableView.delegate = self
        
        // register cell xib
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "countryCell")
        
        // making table view lool good
        // separator - разделитель
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! TableViewCell
        
        let country = countries[indexPath.item]
        cell.countryLabel.text = country
        cell.countryImgView.image = UIImage(named: country)
        
        // make cell look round
        cell.countryView.layer.cornerRadius = cell.countryView.frame.height / 2
        cell.countryImgView.layer.cornerRadius = cell.countryImgView.frame.height / 2
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

