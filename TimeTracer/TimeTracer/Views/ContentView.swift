//
//  ContentView.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var timetracerVM: TimeTracerViewModel
    @State private var selectedDay: WeekDay = .mon
    let currentDay = WeekDay.fromDate(Date())
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                
                    WeeklyAverageView()
                        .padding(.horizontal)
                    
                    ScreenTimeGraphView()
                    
                    // Les plus utilisés
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Les plus utilisés")
                            .font(.headline)
                            .padding(.top, 16)
                            .padding(.horizontal)

                        VStack(spacing: 12) {
                            ForEach(timetracerVM.selectedDay == nil ?
                                    timetracerVM.appsForWeek() :
                                    timetracerVM.appsForSelectedDay()) { app in
                                AppView(app: app)
                                    .environmentObject(timetracerVM)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    PomodoroView()
                }
                .padding(.top)
            }
            .background(Color(.systemGray6))
            .navigationTitle("TimeTracer")
        }
    }
}


struct WeeklyAverageView: View {
    @EnvironmentObject var timetracerVM: TimeTracerViewModel
    
    var body: some View {
        let weeklyAverage = calculateWeeklyAverage()
        
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Moyenne de la semaine")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("\(weeklyAverage.hours)h \(weeklyAverage.minutes)min")
                    .font(.title)
                    .bold()
                
                Text("sur \(weeklyAverage.daysCount) jours")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    private func calculateWeeklyAverage() -> (hours: Int, minutes: Int, daysCount: Int) {
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
        
        return (averageSeconds / 3600, (averageSeconds % 3600) / 60, activeDaysCount)
    }
}

#Preview {
    ContentView()
        .environmentObject(TimeTracerViewModel())
}
