//
//  OrdersTableViewController.swift
//  JustTryingCoreData
//
//  Created by Igor on 11.03.2022.
//

import UIKit
import CoreData

class OrdersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Order", keyForSort: "date")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
    
    func configCell(cell: UITableViewCell, order: Order) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let nameOfClient = (order.client == nil) ? "-- Unknown --" : (order.client?.name)
        cell.textLabel?.text = formatter.string(from: order.date!) + "\t" + nameOfClient!
        
    }
    
    // MARK: - Make table updates
    
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
                let order = fetchedResultsController.object(at: indexPath) as! Order
                let cell = tableView(tableView, cellForRowAt: indexPath)
                configCell(cell: cell, order: order)
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
    
    // MARK: - Delete row
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
            CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = self.fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath)
        
        let order = fetchedResultsController.object(at: indexPath) as! Order
        configCell(cell: cell, order: order)

        return cell
    }

    @IBAction func AddOrder(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ordersToOrder", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = fetchedResultsController.object(at: indexPath) as? Order
        performSegue(withIdentifier: "ordersToOrder", sender: order)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ordersToOrder" {
            let controller = segue.destination as! OrderViewController
            controller.order = sender as? Order
        }
    }
}
