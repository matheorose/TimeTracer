//
//  ScreenTimeGraphView.swift
//  TimeTracer
//
//  Created by rose matheo on 20/03/2025.
//

import SwiftUI

struct ScreenTimeGraphView: View {
    @EnvironmentObject var timetracerVM: TimeTracerViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Moyenne quotidienne")
                .font(.headline)
                .padding(.bottom, 8)

            HStack(alignment: .bottom, spacing: 12) {
                ForEach(WeekDay.allCases) { day in
                    let value = timetracerVM.totalTime(for: day)
                    let maxValue = WeekDay.allCases.map { timetracerVM.totalTime(for: $0) }.max() ?? 1

                    VStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(timetracerVM.selectedDay == day ? Color.blue : Color.gray.opacity(0.4))
                            .frame(height: CGFloat(value) / CGFloat(maxValue) * 120)
                            .onTapGesture {
                                withAnimation {
                                    timetracerVM.selectedDay = day
                                }
                            }

                        Text(day.rawValue)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }

            let selectedTotal = timetracerVM.totalTime(for: timetracerVM.selectedDay)
            Text("\(selectedTotal / 3600)h \(selectedTotal % 3600 / 60)min")
                .font(.title)
                .bold()
                .padding(.top, 12)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

#Preview {
    ScreenTimeGraphView()
}
