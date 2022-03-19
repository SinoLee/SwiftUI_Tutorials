//
//  Task.swift
//  TaskManagement
//
//  Created by Taeyoun Lee on 2022/03/19.
//

import SwiftUI

// Task Model
struct Task: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
