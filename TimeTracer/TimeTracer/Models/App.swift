//
//  App.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import Foundation

enum WeekDay: String, CaseIterable, Identifiable {
    case mon = "LUN"
    case tue = "MAR"
    case wed = "MER"
    case thu = "JEU"
    case fri = "VEN"
    case sat = "SAM"
    case sun = "DIM"

    var id: String { rawValue }
}

struct Application: Identifiable{
    var id = UUID()
    var logo: String
    var title: String
    var dailyScreenTime: [WeekDay: Int]
    
    static var testData: [Application] = [
            Application(logo: "logo-tiktok", title: "TikTok", dailyScreenTime: [
                .mon: 3600, .tue: 2800, .wed: 1800, .thu: 4000, .fri: 3200, .sat: 0, .sun: 0
            ]),
            Application(logo: "logo-snapchat", title: "Snapchat", dailyScreenTime: [
                .mon: 3000, .tue: 2000, .wed: 2400, .thu: 3200, .fri: 2900, .sat: 0, .sun: 0
            ]),
            Application(logo: "logo-instagram", title: "Instagram", dailyScreenTime: [
                .mon: 1800, .tue: 2200, .wed: 2100, .thu: 2500, .fri: 2600, .sat: 0, .sun: 0
            ]),
            Application(logo: "logo-linkedin", title: "Linkedin", dailyScreenTime: [
                .mon: 1400, .tue: 800, .wed: 2300, .thu: 2000, .fri: 2700, .sat: 0, .sun: 0
            ]),
            Application(logo: "logo-youtube", title: "Youtube", dailyScreenTime: [
                .mon: 1000, .tue: 2300, .wed: 2000, .thu: 2200, .fri: 2400, .sat: 0, .sun: 0
            ])
        ]
}

extension WeekDay {
    static func fromDate(_ date: Date) -> WeekDay {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: date)
        switch weekdayIndex {
        case 1: return .sun
        case 2: return .mon
        case 3: return .tue
        case 4: return .wed
        case 5: return .thu
        case 6: return .fri
        case 7: return .sat
        default: return .mon
        }
    }
}
