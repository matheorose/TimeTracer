//
//  PomodoroView.swift
//  TimeTracer
//
//  Created by rose matheo on 20/03/2025.
//

import SwiftUI

struct PomodoroView: View {
    @State private var timerRemaining: Int? = nil
    @State private var isRunning = false
    @State private var currentRestriction: Restriction? = nil
    @State private var timer: Timer?

    @EnvironmentObject var timetracerVM: TimeTracerViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Pomodoro")
                    .font(.headline)

                Spacer()

                NavigationLink(destination: AddRestrictionView()) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }
            .padding(.top, 16)
            .padding(.horizontal)

            VStack(spacing: 12) {
                ForEach(timetracerVM.restrictions) { restriction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(restriction.name)
                                .font(.system(size: 16, weight: .medium))
                            Text(formatTime(restriction.duration))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Button(action: {
                            startTimer(for: restriction)
                        }) {
                            Image(systemName: "timer")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                if let remaining = timerRemaining, isRunning {
                    Text("Temps restant: \(formatTime(remaining))")
                        .font(.title3)
                        .padding()
                        .transition(.opacity)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .onDisappear {
            timer?.invalidate()
            timetracerVM.cancelPomodoroNotification()
        }
    }

    private func startTimer(for restriction: Restriction) {
        timer?.invalidate()
        currentRestriction = restriction
        timerRemaining = restriction.duration
        isRunning = true
        
        timetracerVM.schedulePomodoroNotification(duration: restriction.duration)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let remaining = timerRemaining {
                if remaining > 0 {
                    timerRemaining! -= 1
                } else {
                    isRunning = false
                    timer?.invalidate()
                }
            }
        }
        timetracerVM.saveRestrictionsToSharedDefaults()
    }

    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
