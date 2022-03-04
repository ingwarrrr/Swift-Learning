//
//  SelectTimeViewController.swift
//  FindNumber
//
//  Created by Igor on 04.03.2022.
//

import UIKit

class SelectTimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var data:[Int] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = String(data[indexPath.row])
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // сохранение настроек через user defaults
        // UserDefaults.standard.setValue(data[indexPath.row], forKey: "timeForGame")
        // достаем данные из user defaults
        // UserDefaults.standard.integer(forKey: "timeForGame")
        
        // деселектим ячейку ? зачем написал
        tableView.deselectRow(at: indexPath, animated: true)
        
        //сохранение настроек в отдельный класс с user defaults
        Settings.shared.currentSettings.timeForGame = data[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.reloadData()  // перезапускает таблицу  вызывает методы заного
    }
}
