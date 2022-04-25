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
    func loadTasks() -> [TaskProtocol] {
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
        return testTasks
    }
    
    func saveTasks(_ tasks: [TaskProtocol]) {
        // TODO: save tasks
    }
}
