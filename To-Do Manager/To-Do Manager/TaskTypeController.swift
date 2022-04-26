//
//  TaskTypeController.swift
//  To-Do Manager
//
//  Created by Igor on 26.04.2022.
//

import UIKit

class TaskTypeController: UITableViewController {
    
    // 1. кортеж описывающий тип задачи
    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
    // 2. коллекция доступных типов задач с их описанием
    private var taskTypesInformation: [TypeCellDescription] = [
        (type: .important, title: "Важная", description: "Такой тип задач является наиболее приоритетным для выполнения. Все важные задачи выводятся в самом верху списка задач"),
        (type: .normal, title: "Текущая", description: "Задача с обычным приоритетом")
    ]
    
    // 3. выбранный приоритет
    var selectedType: TaskPriority = .normal

    override func viewDidLoad() {
        super.viewDidLoad()

        // 4. получение значение типа UINib соответствующее xib-file кастомной ячейки
        let cellTypenNib = UINib(nibName: "TaskTypeCell", bundle: nil)
        // 5. регистрация кастом. ячейки
        tableView.register(cellTypenNib, forCellReuseIdentifier: "TaskTypeCell")
    }

    // обработчик выбора типа
    var doAfterTypeSelected: ((TaskPriority) -> Void)?
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTypeCell", for: indexPath) as! TaskTypeCell
        let typeDescription = taskTypesInformation[indexPath.row]
        
        cell.typeTitle.text = typeDescription.title
        cell.typeDescription.text = typeDescription.description
        
        if selectedType == typeDescription.type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskTypesInformation.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // получаем выбранный тип
        let selectedType = taskTypesInformation[indexPath.row].type
        // вызов обработика
        doAfterTypeSelected?(selectedType)
        // переход к предыдущему контроллеру
        navigationController?.popViewController(animated: true)
    }
}
