//
//  Restriction.swift
//  TimeTracer
//
//  Created by rose matheo on 20/03/2025.
//

import Foundation

struct Restriction: Identifiable {
    var id = UUID()
    var name: String
    var duration: Int // en secondes
    
    static var testData: [Restriction] = [
        Restriction(name: "Pause travail", duration: 1500), // 25 min
        Restriction(name: "Pause déj", duration: 3600)      // 1h
    ]
}
