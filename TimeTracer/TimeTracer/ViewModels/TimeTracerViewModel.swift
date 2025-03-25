//
//  TimeTracerViewModel.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import Foundation
import WidgetKit

class TimeTracerViewModel: ObservableObject {
    @Published var apps: [Application] = []
    @Published var selectedDay: WeekDay = .mon
    @Published var restrictions: [Restriction] = []
    
    init() {
        self.apps = Application.testData
        self.restrictions = Restriction.testData
    }
    
    func getRestrictions() -> [Restriction] {
           return restrictions
       }
       
   func getTopRestrictions(limit: Int = 2) -> [Restriction] {
       return Array(restrictions.prefix(limit))
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
        saveRestrictionsToSharedDefaults()
        
    }
    
    func saveRestrictionsToSharedDefaults(){
        let sharedDefaults = UserDefaults(suiteName: "group.com.tonapp.screenTime")
        
        if let encoded = try? JSONEncoder().encode(restrictions){
            sharedDefaults?.set(encoded, forKey: "shared_restrictions")
        }
    }
    
    func syncWithWidget() {
        let defaults = UserDefaults(suiteName: "group.com.tonapp.timetracer")
        
        let today = WeekDay.fromDate(Date())
        let screenTimeToday = totalTime(for: today)
        defaults?.set(screenTimeToday, forKey: "screenTimeToday")
        
        let topRestrictions = restrictions.prefix(2).map { $0.name }
        defaults?.set(topRestrictions, forKey: "topRestrictions")

        WidgetCenter.shared.reloadAllTimelines()    }
}
