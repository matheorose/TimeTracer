//
//  TimeTracerViewModel.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import Foundation
import WidgetKit
import UserNotifications

class TimeTracerViewModel: ObservableObject {
    @Published var apps: [Application] = []
    @Published var selectedDay: WeekDay = .mon
    @Published var restrictions: [Restriction] = []
    
    init() {
        self.apps = Application.testData
        self.restrictions = Restriction.testData
        requestNotificationPermission()
    }
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted!")
            } else {
                print("Notification permission denied!")
            }
        }
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

        if let userDefaults = UserDefaults(suiteName: "group.com.yourAppgroup") {
            let eventDic = NSMutableDictionary()
            eventDic.setValue("Mon Événement", forKey: "title")
            eventDic.setValue(Date(), forKey: "date")
            
            let eventsArray = [eventDic] // Stocker sous forme de tableau pour être cohérent avec la récupération
            let resultData = try? NSKeyedArchiver.archivedData(withRootObject: eventsArray, requiringSecureCoding: false)
            
            userDefaults.set(resultData, forKey: "myWidgetData")
            userDefaults.synchronize()
        }
    }
    
    func schedulePomodoroNotification(duration: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Temps de pause terminé !"
        content.body = "Retourne profiter de la vraie vie maintenant !"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(duration), repeats: false)

        let request = UNNotificationRequest(identifier: "pomodoroEnd", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erreur lors de la planification de la notification : \(error.localizedDescription)")
            }
        }
    }
    
    func cancelPomodoroNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["pomodoroEnd"])
    }
    
    func syncWithWidget() {
        let defaults = UserDefaults(suiteName: "group.com.tonapp.timetracer")
            
        let today = WeekDay.fromDate(Date())
        let screenTimeToday = totalTime(for: today)
        defaults?.set(screenTimeToday, forKey: "screenTimeToday")

        let sharedDefaults = UserDefaults(suiteName: "group.com.tonapp.screenTime")
        
        do {
            let encodedRestrictions = try JSONEncoder().encode(restrictions)
            sharedDefaults?.set(encodedRestrictions, forKey: "shared_restrictions")
            sharedDefaults?.synchronize()
            print("🔄 Widget mis à jour avec \(restrictions.count) restrictions")
        } catch {
            print("❌ Erreur lors de la mise à jour des restrictions pour le widget : \(error)")
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}
