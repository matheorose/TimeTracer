//
//  TimeTracerViewModel.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import Foundation

class TimeTracerViewModel: ObservableObject {
    @Published var apps: [Application] = []
    @Published var selectedDay: WeekDay = .mon
    @Published var restrictions: [Restriction] = []

    init() {
        self.apps = Application.testData
    }

    func totalTime(for day: WeekDay) -> Int {
        apps.reduce(0) { $0 + ($1.dailyScreenTime[day] ?? 0) }
    }

    func appsForSelectedDay() -> [Application] {
        apps.filter { ($0.dailyScreenTime[selectedDay] ?? 0) > 0 }
            .sorted { ($0.dailyScreenTime[selectedDay] ?? 0) > ($1.dailyScreenTime[selectedDay] ?? 0) }
    }
    
    func addRestriction(_ restriction: Restriction) {
        restrictions.append(restriction)
    }
}
