//
//  TasksList.swift
//  TryingRealm
//
//  Created by Igor on 24.03.2022.
//

import Foundation
import RealmSwift

class TasksList: Object {
    @objc dynamic var task = ""
    @objc dynamic var compleated = false
}
