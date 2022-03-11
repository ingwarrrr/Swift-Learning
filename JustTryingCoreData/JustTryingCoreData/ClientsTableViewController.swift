//
//  ClientsTableViewController.swift
//  JustTryingCoreData
//
//  Created by Igor on 10.03.2022.
//

import UIKit
import CoreData

class ClientsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Client", keyForSort: "name")

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
                let client = fetchedResultsController.object(at: indexPath) as! Client
                let cell = tableView(tableView, cellForRowAt: indexPath)
                cell.textLabel?.text = client.name
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let client = fetchedResultsController.object(at: indexPath) as! Client
        cell.textLabel?.text = client.name

        return cell
    }

    @IBAction func AddClient(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "clientsToClient", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = fetchedResultsController.object(at: indexPath) as? Client
        performSegue(withIdentifier: "clientsToClient", sender: client)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clientsToClient" {
            let controller = segue.destination as! ClientViewController
            controller.client = sender as? Client
        }
    }
}
