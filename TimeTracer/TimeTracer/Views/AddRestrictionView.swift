//
//  AddRestrictionView.swift
//  TimeTracer
//
//  Created by rose matheo on 20/03/2025.
//

import SwiftUI

struct AddRestrictionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timetracerVM: TimeTracerViewModel
    
    @State private var name: String = ""
    @State private var hours = 0
    @State private var minutes = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Button("Retour") {
                    presentationMode.wrappedValue.dismiss()
                }

                Spacer()

                Button("Enregistrer") {
                    let totalSeconds = (hours * 60 + minutes) * 60
                    let new = Restriction(name: name, duration: totalSeconds)
                    timetracerVM.restrictions.append(new)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding(.horizontal)
            .padding(.top)

            Text("Ajouter une restriction")
                .font(.title2)
                .padding(.horizontal)

            TextField("Nom de la restriction", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            VStack(spacing: 8) {
                Text("Durée d'utilisation")
                    .font(.headline)

                HStack {
                    Picker("Heures", selection: $hours) {
                        ForEach(0..<24) { Text("\($0) h") }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    .clipped()

                    Picker("Minutes", selection: $minutes) {
                        ForEach(0..<60) { Text("\($0) min") }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    .clipped()
                }
                .frame(height: 100)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal)

            Spacer()
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }
}
