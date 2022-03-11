//
//  ClientViewController.swift
//  JustTryingCoreData
//
//  Created by Igor on 10.03.2022.
//

import UIKit
import CoreData

class ClientViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var infoTextiField: UITextField!
    
    var client: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let client = client {
            nameTextField.text = client.name
            infoTextiField.text = client.info
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if saveClient() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveClient() -> Bool {
        // проверка запрошеных полей
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Предупреждение", message: "Заполните поле имени", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        // создание объекта
        if client == nil {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Client", in: CoreDataManager.instance.persistentContainer.viewContext)
            client = Client(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        }
        
        // сохранение объекта
        if let client = client {
            client.name = nameTextField.text
            client.info = infoTextiField.text
            CoreDataManager.instance.saveContext()
        }
        
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
