//
//  TaskViewModel.swift
//  TaskManagement
//
//  Created by Taeyoun Lee on 2022/03/19.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    
    // Sample Tasks
    @Published var storedTasks: [Task] = [
        
        // TimeInterval - 1day : 86400
        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 9)),
        Task(taskTitle: "Team Party", taskDescription: "Make fun with team mates", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 14)),
        Task(taskTitle: "Client Meeting", taskDescription: "Explain Project to client", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 15)),
        Task(taskTitle: "Next Project", taskDescription: "Discuss next project with team", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 16)),
        Task(taskTitle: "App Proposal", taskDescription: "Meet client for next App Proposal", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 17)),
        Task(taskTitle: "Icon set", taskDescription: "Edit icons for team task for next week", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 10)),
        Task(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 11)),
        Task(taskTitle: "Check asset", taskDescription: "Start checking the assets", taskDate: Calendar.current.startOfDay(for: Date()).addingTimeInterval(3600 * 13)),
    ]
    
    // MARK: Current Week Days
    @Published var currentWeek: [Date] = []
    
    // MARK: Current Day
    @Published var currentDay: Date = Date()
    
    // MARK: Filtering Today Tasks
    @Published var filteredTasks: [Task]?
    
    // MARK: Initializing
    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    // MARK: Filter Today Tasks
    func filterTodayTasks() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter {
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
                .sorted { task1, task2 in
                    return task2.taskDate > task1.taskDate
                }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }
    
    func fetchCurrentWeek() {
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...7).forEach { day in
            
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    // MARK: Extracting Date
    func extractDate(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
    
    // MARK: Checking if current Date is Today
    func isToday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    // MARK: Checking if the currentHour is task Hour
    func isCurrentHour(_ date: Date) -> Bool {
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
