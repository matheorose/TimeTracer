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
        NavigationView{
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    ScreenTimeGraphView()
                    // Les plus utilisés
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Les plus utilisés")
                            .font(.headline)
                            .padding(.top, 16)
                            .padding(.horizontal)

                        VStack(spacing: 12) {
                            ForEach(timetracerVM.apps) { app in
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

#Preview {
    ContentView()
        .environmentObject(TimeTracerViewModel())
}

