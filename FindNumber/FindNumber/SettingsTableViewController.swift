//
//  SettingsTableViewController.swift
//  FindNumber
//
//  Created by Igor on 04.03.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var switchTimer: UISwitch!
    @IBOutlet weak var timeGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    func loadSettings() {
        timeGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) сек"
        switchTimer.isOn = Settings.shared.currentSettings.timeState
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10, 20, 30, 40, 50, 60, 70]
            }
        default:
            break
        }
    }
    
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timeState = sender.isOn
    }
    
    @IBAction func resetSettings(_ sender: UIButton) {
        Settings.shared.resetSettings()
        loadSettings()
    }
}
