//
//  AppView.swift
//  TimeTracer
//
//  Created by rose matheo on 19/03/2025.
//

import SwiftUI

struct AppView: View {
    let app: Application
    @EnvironmentObject var timetracerVM: TimeTracerViewModel
    
    var body: some View {
        HStack{
            Image(app.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
            Text(app.title.capitalized)
                .font(.system(size: 18, weight: .medium))
            
            Spacer()
            
            if let selectedDay = timetracerVM.selectedDay {
                if let seconds = app.dailyScreenTime[selectedDay] {
                    Text(formattedScreenTime(for: seconds))
                }
            } else {
                let totalSeconds = WeekDay.allCases.reduce(0) { $0 + (app.dailyScreenTime[$1] ?? 0) }
                Text(formattedScreenTime(for: totalSeconds))
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
    private func formattedScreenTime(for seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        return "\(hours)h \(minutes)min"
    }
}

#Preview {
    AppView(app: Application.testData[0])
        .environmentObject(TimeTracerViewModel())
}
