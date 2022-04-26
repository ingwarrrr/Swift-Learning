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
        
        return resultTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String: String]] = []
        tasks.forEach { task in
            var newElemForStorage: Dictionary<String, String> = [:]
            newElemForStorage[TaskKey.title.rawValue] = task.title
            newElemForStorage[TaskKey.type.rawValue] = (task.type == .important) ? "important" : "normal"
            newElemForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "completed"
            arrayForStorage.append(newElemForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
