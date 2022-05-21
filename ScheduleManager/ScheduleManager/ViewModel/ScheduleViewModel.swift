//
//  ScheduleViewModel.swift
//  ScheduleManager
//
//  Created by Taeyoun Lee on 2022/05/13.
//

import SwiftUI
import CoreData
import UserNotifications

class ScheduleViewModel: ObservableObject {
    // MARK: New Schedule Properties
    @Published var addNewSchedule: Bool = false
    
    @Published var title: String = ""
    @Published var scheduleColor: String = "Card-1"
    @Published var weekDays: [String] = []
    @Published var isRemainderOn: Bool = false
    @Published var remainderText: String = ""
    @Published var remainderDate: Date = Date()
    
    // MARK: Remainder time picker
    @Published var showTimePicker: Bool = false
    
    // MARK: Editing Schedule
    @Published var editSchedule: Schedule?
    
    // MARK: Notification Access status
    @Published var notificationAccess: Bool = false
    
    init() {
        requestNotificationAccess()
    }
    
    func requestNotificationAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { status, _ in
            DispatchQueue.main.async {
                self.notificationAccess = status
            }
        }
    }
    
    // MARK: Adding schedule to database
    func addSchedule(context: NSManagedObjectContext) async -> Bool {
        // MARK: Editing Data
        var schedule: Schedule!
        if let editSchedule = editSchedule {
            schedule = editSchedule
            // Removing all pending notifications
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: editSchedule.notificationIDs ?? [])
        } else {
            schedule = Schedule(context: context)
        }
        schedule.title = title
        schedule.color = scheduleColor
        schedule.weekDays = weekDays
        schedule.isRemainderOn = isRemainderOn
        schedule.remainderText = remainderText
        schedule.notificationDate = remainderDate
        schedule.notificationIDs = []
        
        if isRemainderOn {
            // MARK: Scheduling notifications
            if let ids = try? await scheduleNotification() {
                schedule.notificationIDs = ids
                if let _ = try? context.save() {
                    return true
                }
            }
        } else {
            // MARK: Adding Data
            if let _ = try? context.save() {
                return true
            }
        }
        return false
    }
    
    // MARK: Adding notifications
    func scheduleNotification() async throws -> [String] {
        let content = UNMutableNotificationContent()
        content.title = "Schedule Remainder"
        content.subtitle = remainderText
        content.sound = UNNotificationSound.default
        
        // Scheduled Ids
        var notificationIDs: [String] = []
        let calender = Calendar.current
        let weekdaySymbols: [String] = calender.weekdaySymbols
        
        // MARK: Scheduling notification
        for weekDay in weekDays {
            // UNIQUE id for each notification
            let id = UUID().uuidString
            let hour = calender.component(.hour, from: remainderDate)
            let min = calender.component(.minute, from: remainderDate)
            let day = weekdaySymbols.firstIndex { currentDay in
                return currentDay == weekDay
            } ?? -1
            // MARK: Since week day starts from 1-7
            // thus adding +1 to Index
            if day != -1 {
                var components = DateComponents()
                components.hour = hour
                components.minute = min
                components.weekday = day + 1
                
                // MARK: Thus this will trigger notification on each selected day
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                
                // MARK: Notification request
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                
                try await UNUserNotificationCenter.current().add(request)
                
                // ADDING ID
                notificationIDs.append(id)
            }
        }
        
        return notificationIDs
    }
    
    // MARK: Erasing Content
    func resetData() {
        title = ""
        scheduleColor = "Card-1"
        weekDays = []
        isRemainderOn = false
        remainderDate = Date()
        remainderText = ""
        editSchedule = nil
    }
    
    // MARK: Deleting Schedule from database
    func deleteSchedule(context: NSManagedObjectContext) -> Bool {
        if let editSchedule = editSchedule {
            if editSchedule.isRemainderOn {
                // Removing all pending notifications
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: editSchedule.notificationIDs ?? [])
            }
            context.delete(editSchedule)
            if let _ = try? context.save() {
                return true
            }
        }
        
        return false
    }
    
    // MARK: Restoring Edit Data
    func restoreEditData() {
        if let editSchedule = editSchedule {
            title = editSchedule.title ?? ""
            scheduleColor = editSchedule.color ?? "Card-1"
            weekDays = editSchedule.weekDays ?? []
            isRemainderOn = editSchedule.isRemainderOn
            remainderDate = editSchedule.notificationDate ?? Date()
            remainderText = editSchedule.remainderText ?? ""
        }
    }
    
    // MARK: Done Button Status
    func doneStatus() -> Bool {
        let remainderStatus = isRemainderOn ? remainderText == "" : false
        
        if title == "" || weekDays.isEmpty || remainderStatus {
            return false
        }
        return true
    }
}
