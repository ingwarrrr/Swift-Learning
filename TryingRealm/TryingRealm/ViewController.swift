//
//  ViewController.swift
//  TryingRealm
//
//  Created by Igor on 24.03.2022.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    let realm = try! Realm() // Доступ к хранилищу
    
    var itemsArray: Results<TasksList>! // Массив для хранения записей
    var cellId = "Cell" // Идентификатор ячейки

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .lightGray
        
        // Цвет навигейшин бара
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 21/255,
                                                                   green: 101/255,
                                                                   blue: 192/255,
                                                                   alpha: 1)
        // Цвет текста для кнопки
        navigationController?.navigationBar.tintColor = .white
        
        // Добавляем кнопку "Добавить" в навигейшин бар
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addItem)) // Вызов метода для кнопки
        // Присваиваем ячейку для TableView с иднетифиактором "Cell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        itemsArray = realm.objects(TasksList.self)
    }
    
    // Действие при нажатии на кнопку "Добавить"
    @objc func addItem(_ sender: AnyObject) {
        addAlertForNewItem()
    }
    
    func addAlertForNewItem() {
        
        // Создание алёрт контроллера
        let alert = UIAlertController(title: "Новая задача", message: "Пожалуйста заполните поле", preferredStyle: .alert)
        
        // Создание текстового поля
        var alertTextField: UITextField!
        alert.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Новая задача"
        }
        
        // Создание кнопки для сохранения новых значений
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
            
            // Проверяем не является ли текстовое поле пустым
            guard alertTextField.text?.isEmpty == false else {
                print("The text field is empty")
                return
            }
            
            let task = TasksList()
            task.task = (alert.textFields?.first?.text)!
            //  добавление задачи в хранилище
            try! self.realm.write({
                self.realm.add(task)
            })
            
            self.tableView.reloadData()
        }
        
        // Создаем кнопку для отмены ввода новой задачи
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemsArray.count != 0 {
            return itemsArray.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let item = itemsArray[indexPath.row]
        cell.textLabel?.text = item.task
        return cell
    }
    
    //MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = itemsArray[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _,_,_  in
            // удаление строки
            try! self.realm.write({
                self.realm.delete(editingRow)
                self.tableView.reloadData()
                
            })
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
