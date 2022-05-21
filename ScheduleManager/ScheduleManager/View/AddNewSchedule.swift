//
//  AddNewSchedule.swift
//  ScheduleManager
//
//  Created by Taeyoun Lee on 2022/05/15.
//

import SwiftUI

struct AddNewSchedule: View {
    @EnvironmentObject var scheduleModel: ScheduleViewModel
    // MARK: Environment Values
    @Environment(\.self) var env
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                TextField("Title", text: $scheduleModel.title)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color("TFBG").opacity(0.4), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                
                // MARK: Schedule Color picker
                HStack(spacing: 0) {
                    ForEach(1...7, id: \.self) { index in
                        let color = "Card-\(index)"
                        Circle()
                            .fill(Color(color))
                            .frame(width: 30, height: 30)
                            .overlay {
                                if color == scheduleModel.scheduleColor {
                                    Image(systemName: "checkmark")
                                        .font(.caption.bold())
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    scheduleModel.scheduleColor = color
                                }
                            }
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical)
                
                Divider()
                
                // MARK: Frequency selection
                VStack(alignment: .leading, spacing: 6) {
                    Text("Frequency")
                        .font(.callout.bold())
                    let weekDays = Calendar.current.weekdaySymbols
                    HStack(spacing: 10) {
                        ForEach(weekDays, id: \.self) { day in
                            let index = scheduleModel.weekDays.firstIndex { value in
                                return value == day
                            } ?? -1
                            // MARK: Limiting to First 2 letters
                            Text(day.prefix(2))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(index != -1 ? Color(scheduleModel.scheduleColor) : Color("TFBG").opacity(0.4))
                                }
                                .onTapGesture {
                                    withAnimation {
                                        if index != -1 {
                                            scheduleModel.weekDays.remove(at: index)
                                        } else {
                                            scheduleModel.weekDays.append(day)
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.top, 15)
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                // Hiding if notification access is rejected
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Remainder")
                            .fontWeight(.semibold)
                        
                        Text("Just notification")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Toggle(isOn: $scheduleModel.isRemainderOn) {}
                        .labelsHidden()
                }
                .opacity(scheduleModel.notificationAccess ? 1 : 0)
                
                HStack(spacing: 12) {
                    Label {
                        Text(scheduleModel.remainderDate.formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(Color("TFBG").opacity(0.4), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .onTapGesture {
                        withAnimation {
                            scheduleModel.showTimePicker.toggle()
                        }
                    }
                    
                    TextField("Remainder Text", text: $scheduleModel.remainderText)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color("TFBG").opacity(0.4), in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                }
                .frame(height: scheduleModel.isRemainderOn ? nil : 0)
                .opacity(scheduleModel.isRemainderOn ? 1 : 0)
                .opacity(scheduleModel.notificationAccess ? 1 : 0)
            }
            .animation(.easeInOut, value: scheduleModel.isRemainderOn)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(scheduleModel.editSchedule != nil ? "Edit Schedule" : "Add Schedule")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                    .tint(.white)
                }
                
                // MARK: Delete Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if scheduleModel.deleteSchedule(context: env.managedObjectContext) {
                            env.dismiss()
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                    .opacity(scheduleModel.editSchedule == nil ? 0 : 1)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        Task {
                            if await scheduleModel.addSchedule(context: env.managedObjectContext) {
                                env.dismiss()
                            }
                        }
                    }
                    .tint(.white)
                    .disabled(!scheduleModel.doneStatus())
                    .opacity(scheduleModel.doneStatus() ? 1 : 0.6)
                }
            }
        }
        .overlay {
            if scheduleModel.showTimePicker {
                ZStack {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                scheduleModel.showTimePicker.toggle()
                            }
                        }
                    
                    DatePicker("", selection: $scheduleModel.remainderDate, displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("TFBG"))
                        }
                        .padding()
                }
            }
        }
    }
}

struct AddNewSchedule_Previews: PreviewProvider {
    static var previews: some View {
        AddNewSchedule()
            .environmentObject(ScheduleViewModel())
            .preferredColorScheme(.dark)
    }
}
