//
//  ScreenTimeGraphView.swift
//  TimeTracer
//
//  Created by rose matheo on 20/03/2025.
//

import SwiftUI

struct ScreenTimeGraphView: View {
    @EnvironmentObject var timetracerVM: TimeTracerViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(timetracerVM.selectedDay == nil ? "Moyenne quotidienne" : "Temps d'écran")
                .font(.headline)
                .padding(.bottom, 8)
            
            HStack(alignment: .bottom, spacing: 12) {
                ForEach(WeekDay.allCases) { day in
                    let value = timetracerVM.totalTime(for: day)
                    let maxValue = WeekDay.allCases.map { timetracerVM.totalTime(for: $0) }.max() ?? 1
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(timetracerVM.selectedDay == day ? Color.blue : Color.gray.opacity(0.4))
                            .frame(height: CGFloat(value) / CGFloat(maxValue) * 120)
                            .onTapGesture {
                                withAnimation {
                                    if timetracerVM.selectedDay == day {
                                        timetracerVM.selectedDay = nil 
                                    } else {
                                        timetracerVM.selectedDay = day
                                    }
                                }
                            }
                        
                        Text(day.rawValue)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            if let selectedDay = timetracerVM.selectedDay {
                let selectedTotal = timetracerVM.totalTime(for: selectedDay)
                Text("\(selectedTotal / 3600)h \(selectedTotal % 3600 / 60)min")
                    .font(.title)
                    .bold()
                    .padding(.top, 12)
            } else {
                let weeklyAverage = calculateWeeklyAverage()
                Text("\(weeklyAverage.hours)h \(weeklyAverage.minutes)min")
                    .font(.title)
                    .bold()
                    .padding(.top, 12)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal)
        .onTapGesture {
            withAnimation {
                timetracerVM.selectedDay = nil
            }
        }
    }
    
    private func calculateWeeklyAverage() -> (hours: Int, minutes: Int) {
        var totalSeconds = 0
        var activeDaysCount = 0
        
        for day in WeekDay.allCases {
            let daySeconds = timetracerVM.totalTime(for: day)
            if daySeconds > 0 {
                totalSeconds += daySeconds
                activeDaysCount += 1
            }
        }
        
        let divisor = max(1, activeDaysCount)
        let averageSeconds = totalSeconds / divisor
        
        return (averageSeconds / 3600, (averageSeconds % 3600) / 60)
    }
}

#Preview {
    ScreenTimeGraphView()
}
