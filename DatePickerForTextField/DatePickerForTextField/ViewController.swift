//
//  ViewController.swift
//  DatePickerForTextField
//
//  Created by Igor on 21.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var someDateField: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create DPicker
        createDatePicker()
        
    }

    func createToolbar() -> UIToolbar {
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        // set donebtn to toolbar
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createDatePicker() {
        // DP mode and style
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        someDateField.textAlignment = .center
        someDateField.inputView = datePicker
        someDateField.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed() {
        // formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        someDateField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func showCountryDP(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CountryVC = storyboard.instantiateViewController(withIdentifier: "countryVC")
        
        show(CountryVC, sender: self)
//        CountryVC.modalPresentationStyle = .fullScreen
//        CountryVC.modalTransitionStyle = .crossDissolve
//        present(CountryVC, animated: true)
        
    }
}

