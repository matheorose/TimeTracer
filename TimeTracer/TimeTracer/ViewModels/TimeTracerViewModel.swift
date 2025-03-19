//
//  TimeTracerViewModel.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import Foundation

class TimeTracerViewModel: ObservableObject{
    @Published var apps : [Application] = []
    
    init (){
        getApps()
    }
    
    func getApps(){
        self.apps.append(contentsOf: Application.testData)
    }
    
}
