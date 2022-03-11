//
//  ServiceViewController.swift
//  JustTryingCoreData
//
//  Created by Igor on 10.03.2022.
//

import UIKit
import CoreData

class ServiceViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextiField: UITextField!
    
    var service: Service?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let service = service {
            nameTextField.text = service.name
            infoTextiField.text = service.info
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if saveService() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveService() -> Bool {
        // проверка запрошеных полей
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Предупреждение", message: "Заполните поле услуги", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        // создание объекта
        if service == nil {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Service", in: CoreDataManager.instance.persistentContainer.viewContext)
            service = Service(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        }
        
        // сохранение объекта
        if let service = service {
            service.name = nameTextField.text
            service.info = infoTextiField.text
            CoreDataManager.instance.saveContext()
        }
        
        return true
    }

}
