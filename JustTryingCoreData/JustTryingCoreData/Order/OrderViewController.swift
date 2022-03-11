//
//  OrderViewController.swift
//  JustTryingCoreData
//
//  Created by Igor on 11.03.2022.
//

import UIKit
import CoreData

class OrderViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var order: Order?
    var table: NSFetchedResultsController<NSFetchRequestResult>?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textFieldClient: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchMade: UISwitch!
    @IBOutlet weak var switchPaid: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // создание объекта
        if order == nil {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Order", in: CoreDataManager.instance.persistentContainer.viewContext)
            order = Order(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
            order?.date = Date()
        }
        
        if let order = order {
            datePicker.date = order.date!
            switchMade.isOn = order.made
            switchPaid.isOn = order.paid
            textFieldClient.text = order.client?.name
            
            table = Order.getRowsOfOrder(order: order)
            table?.delegate = self
            do {
                try table?.performFetch()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if saveOrder() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choiceClient(_ sender: UIButton) {
        performSegue(withIdentifier: "orderToClients", sender: nil)
    }
    
    @IBAction func addRowOfOrder(_ sender: Any) {
        if let order = order {
            let entityDescription = NSEntityDescription.entity(forEntityName: "RowOfOrder", in: CoreDataManager.instance.persistentContainer.viewContext)
            let newRowOfOrder = RowOfOrder(entity: entityDescription!, insertInto: CoreDataManager.instance.persistentContainer.viewContext)
            
            newRowOfOrder.order = order
            performSegue(withIdentifier: "orderToRowOfOrder", sender: newRowOfOrder)
        }
    }
    
    func saveOrder() -> Bool {
        // сохранение объекта
        if let order = order {
            order.date = datePicker.date
            order.made = switchMade.isOn
            order.paid = switchPaid.isOn
            CoreDataManager.instance.saveContext()
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "orderToClients" {
            let viewController = segue.destination as! ClientsTableViewController
            viewController.didSelect = { [unowned self] (client) in
                self.order?.client = client
                self.textFieldClient.text = client.name
            }
        }
        if segue.identifier == "orderToRowOfOrder" {
            let viewController = segue.destination as! RowOfOrderViewController
            viewController.rowOfOrder = sender as? RowOfOrder
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = table?.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowOfOrder = table?.object(at: indexPath) as! RowOfOrder
        let cell = UITableViewCell()
        let nameOfService = (rowOfOrder.service == nil) ? "-- Unknown --" : (rowOfOrder.service?.name)
        cell.textLabel?.text = nameOfService! + " - " + String(rowOfOrder.sum)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowOfOrder = table?.object(at: indexPath) as? Client
        performSegue(withIdentifier: "orderToRowOfOrder", sender: rowOfOrder)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = table?.object(at: indexPath) as! RowOfOrder
            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let rowOfOrder = table?.object(at: indexPath) as! RowOfOrder
                let cell = tableView(tableView, cellForRowAt: indexPath)
                let nameOfService = (rowOfOrder.service == nil) ? "-- Uncnown --" : (rowOfOrder.service?.name)
                cell.textLabel?.text = nameOfService! + " - " + String(rowOfOrder.sum)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension Order: NSFetchedResultsControllerDelegate {
    class func getRowsOfOrder(order: Order) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RowOfOrder")
        let sortDescriptor = NSSortDescriptor(key: "service.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "%K == %@", "order", order)
        fetchRequest.predicate = predicate
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
}
