//
//  App.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import Foundation

struct Application: Identifiable{
    var id = UUID()
    var logo: String
    var title: String
    var screenTime: Int
    
    static var testData = [
        Application(logo:"logo-tiktok", title: "tiktok", screenTime: 512),
        Application(logo:"logo-snapchat", title: "snapchat", screenTime: 414),
        Application(logo:"logo-instagram", title: "instagram", screenTime: 152),
        Application(logo:"logo-tiktok", title: "tiktok", screenTime: 58),
    ]
}
