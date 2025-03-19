//
//  TimeTracerApp.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import SwiftUI

@main
struct TimeTracerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TimeTracerViewModel())
        }
    }
}
