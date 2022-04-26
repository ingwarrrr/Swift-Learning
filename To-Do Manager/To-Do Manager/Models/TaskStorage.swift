//
//  TaskStorage.swift
//  To-Do Manager
//
//  Created by Igor on 23.04.2022.
//

import Foundation

protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

class TasksStorage: TasksStorageProtocol {
    private var storage = UserDefaults.standard
    // ключ для сохранения и загрузки данных
    var storageKey: String = "tasks"
    
    // перечисление с ключами для записи в UD
    private enum TaskKey: String {
        case title
        case type
        case status
    }
    
    func loadTasks() -> [TaskProtocol] {
        var resultTasks: [TaskProtocol] = []
        let tasksFromStorage = storage.array(forKey: storageKey) as? [[String: String]] ?? []
        
        for task in tasksFromStorage {
            guard let title = task[TaskKey.title.rawValue],
                  let typeRaw = task[TaskKey.type.rawValue],
                  let statusRaw = task[TaskKey.status.rawValue] else {
                continue
            }
            let type: TaskPriority = typeRaw == "important" ? .important : .normal
            let status: TaskStatus = statusRaw == "planned" ? .planned : .completed
            resultTasks.append(Task(title: title, type: type, status: status))
        }
        
        let testTasks: [TaskProtocol] = [
            Task(title: "Купить хлуб", type: .important, status: .planned),
            Task(title: "Помыть руки", type: .important, status: .planned),
            Task(title: "Отдать долг", type: .normal, status: .planned),
            Task(title: "Купить ноут", type: .normal, status: .planned),
            Task(title: "Пригласить на вечеринку Макса,Пашу,Влада, Мишу", type: .normal, status: .planned),
            Task(title: "Продать сувенир", type: .important, status: .completed),
            Task(title: "Позвонить девушке", type: .normal, status: .completed),
            Task(title: "Позвонить супруге", type: .normal, status: .completed)

        ]
        
        for task in testTasks {
            resultTasks.append(task)
        }
        
        return resultTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String: String]] = []
        tasks.forEach { task in
            var newElemForStorage: Dictionary<String, String> = [:]
            newElemForStorage[TaskKey.title.rawValue] = task.title
            newElemForStorage[TaskKey.type.rawValue] = (task.type == .normal) ? "important" : "normal"
            newElemForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElemForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
