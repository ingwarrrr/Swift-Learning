//
//  TaskEditViewController.swift
//  To-Do Manager
//
//  Created by Igor on 26.04.2022.
//

import UIKit

class TaskEditViewController: UITableViewController {
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskTypeLabel: UILabel!
    @IBOutlet weak var taskStatusSwitch: UISwitch!
    
    // параметры задачи
    var taskText: String = ""
    var taskType: TaskPriority = .normal
    var taskStatus: TaskStatus = .planned
    var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    // назване типов задач
    private var taskTitles: [TaskPriority: String] = [
        .important: "Важная",
        .normal: "Текущая"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // обновление текстового поля с названием задачи и тд
        taskTitle.text = taskText
        taskTypeLabel.text = taskTitles[taskType]
        // обновляем статус задачи
        if taskStatus == .completed {
            taskStatusSwitch.isOn = true
        }
    }

    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        guard let title = taskTitle.text, title.trimmingCharacters(in: .whitespaces) != "" else {
            let alert = UIAlertController(title: "Некоректное имя задачи", message: "Введит данные не с пустым именем", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        // получаем актуальные значения
        let type = taskType
        let status: TaskStatus = taskStatusSwitch.isOn ? .completed : .planned
        // вызываем обработчик
        doAfterEdit?(title, type, status)
        // возвращаемся к предыдущему экрану
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskTypeScreen" {
            let destination = segue.destination as! TaskTypeController
            destination.selectedType = taskType
            destination.doAfterTypeSelected = { [unowned self] selectedType in
                taskType = selectedType
                taskTypeLabel?.text = taskTitles[taskType]
            }
        }
    }
}
