//
//  RowOfOrderViewController.swift
//  JustTryingCoreData
//
//  Created by Igor on 11.03.2022.
//

import UIKit
import CoreData

class RowOfOrderViewController: UIViewController {
    @IBOutlet weak var textFieldService: UITextField!
    @IBOutlet weak var textFieldSum: UITextField!
    
    var rowOfOrder: RowOfOrder?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let rowOfOrder = rowOfOrder {
            textFieldService.text = rowOfOrder.service?.name
            textFieldSum.text = String(rowOfOrder.sum)
        } else {
            let entityDescription = NSEntityDescription.entity(forEntityName: "RowOfOrder", in: CoreDataManager.instance.persistentContainer.viewContext)
            rowOfOrder = RowOfOrder(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        saveRow()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choiceRow(_ sender: UIButton) {
        performSegue(withIdentifier: "rowOfOrderToServices", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderToClients" {
            let viewController = segue.destination as! ServicesTableViewController
            viewController.didSelect = { [unowned self] (service) in
                self.rowOfOrder!.service = service
                self.textFieldService.text = service?.name
            }
        }
    }
    
    func saveRow() {
        if let rowOfOrder = rowOfOrder {
            rowOfOrder.sum = Float(textFieldSum.text!)!
            CoreDataManager.instance.saveContext()
        }
    }
    
}
