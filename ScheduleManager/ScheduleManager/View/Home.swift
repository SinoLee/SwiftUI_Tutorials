//
//  Home.swift
//  ScheduleManager
//
//  Created by Taeyoun Lee on 2022/05/13.
//

import SwiftUI

struct Home: View {
    @FetchRequest(entity: Schedule.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Schedule.dateAdded, ascending: false)], predicate: nil, animation: .easeInOut) var schedules: FetchedResults<Schedule>
    @StateObject var scheduleModel: ScheduleViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Schedule")
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .trailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 10)
            
            // Making add button center when schedules empty
            ScrollView(schedules.isEmpty ? .init() : .vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(schedules) { schedule in
                        scheduleCardView(schedule)
                    }
                    
                    // MARK: Add Schedule Button
                    Button {
                        scheduleModel.addNewSchedule.toggle()
                    } label: {
                        Label {
                            Text("New Schedule")
                        } icon: {
                            Image(systemName: "plus.circle")
                        }
                        .font(.callout)
                        .foregroundColor(.white)
                    }
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .padding(.vertical)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding()
        .sheet(isPresented: $scheduleModel.addNewSchedule) {
            // MARK: Erasing All existing context
            scheduleModel.resetData()
        } content: {
            AddNewSchedule()
                .environmentObject(scheduleModel)
        }
    }
    
    // MARK: Schedule card view
    @ViewBuilder
    func scheduleCardView(_ schedule: Schedule) -> some View {
        VStack(spacing: 6) {
            HStack {
                Text(schedule.title ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Image(systemName: "bell.badge.fill")
                    .font(.callout)
                    .foregroundColor(Color(schedule.color ?? "Card-1"))
                    .scaleEffect(0.9)
                    .opacity(schedule.isRemainderOn ? 1 : 0)
                
                Spacer()
                
                let count = schedule.weekDays?.count ?? 0
                Text(count == 7 ? "Everyday" : "\(count) times a weak")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            
            // MARK: Displaying Current week and making active dates of schedule
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
            let activeWeekDays = schedule.weekDays ?? []
            let activePlot = symbols.indices.compactMap { index -> (String, Date) in
                let currentDate = calendar.date(byAdding: .day, value: index, to: startDate)
                return (symbols[index], currentDate!)
            }
            
            HStack(spacing: 0) {
                ForEach(activePlot.indices, id: \.self) { index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6) {
                        // MARK: Limiting to First 3 letters
                        Text(item.0.prefix(3))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        let status = activeWeekDays.contains { day in
                            return day == item.0
                        }
                        
                        Text(getDate(date: item.1))
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(8)
                            .background {
                                Circle()
                                    .fill(Color(schedule.color ?? "Card-1"))
                                    .opacity(status ? 1 : 0)
                            }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 15)
        }
        .padding(.vertical)
        .padding(.horizontal, 6)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color("TFBG").opacity(0.5))
        }
        .onTapGesture {
            // MARK: Editing Schedule
            scheduleModel.editSchedule = schedule
            scheduleModel.restoreEditData()
            scheduleModel.addNewSchedule.toggle()
        }
    }
    
    // MARK: Formatting Date
    func getDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
