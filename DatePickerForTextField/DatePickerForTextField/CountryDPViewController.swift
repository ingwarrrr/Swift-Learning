//
//  CountryDPViewController.swift
//  DatePickerForTextField
//
//  Created by Igor on 21.03.2022.
//

import UIKit

class CountryDPViewController: UIViewController {
    @IBOutlet weak var countryImg: UIImageView!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var chooseCountryPickerView: UIPickerView!
    
    var countries = ["Japan",
                     "China",
                     "UK",
                     "Germany",
                     "Spain",
                     "USA",
                     "France"]

    override func viewDidLoad() {
        super.viewDidLoad()

        chooseCountryPickerView.delegate = self
        chooseCountryPickerView.dataSource = self
    }
}

extension CountryDPViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryLbl.text = countries[row]
        countryImg.image = UIImage(named: countries[row])
    }
}
