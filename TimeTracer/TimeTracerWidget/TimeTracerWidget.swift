//
//  TimeTracerWidget.swift
//  TimeTracerWidget
//
//  Created by rose matheo on 21/03/2025.
//

import WidgetKit
import SwiftUI

struct ScreenTimeEntry: TimelineEntry {
    let date: Date
    let screenTime: String
    let restrictions: [Restriction]
}

struct Provider: TimelineProvider{
    
    func placeholder(in context: Context) -> ScreenTimeEntry {
        ScreenTimeEntry(date: Date(), screenTime: "1h 30min", restrictions: [])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ScreenTimeEntry) -> Void) {
        let entry = loadEntry()
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ScreenTimeEntry>) -> Void) {
        let restrictions = loadSharedRestrictions()
        let topRestrictions = Array(restrictions.prefix(2))
        let entry = loadEntry()
        let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 15)))
        completion(timeline)
    }
    
    func loadEntry() -> ScreenTimeEntry {
        let defaults = UserDefaults(suiteName: "group.com.tonapp.timetracer")
        let seconds = defaults?.integer(forKey: "screenTimeToday") ?? 0
        let restrictions = Array(loadSharedRestrictions().prefix(2))
        
        let formatted = "\(seconds / 3600)h \(seconds % 3600 / 60)min"
        return ScreenTimeEntry(date: Date(), screenTime: formatted, restrictions: restrictions)

    }
    
    func loadSharedRestrictions() -> [Restriction] {
        let sharedDefaults = UserDefaults(suiteName: "group.com.tonapp.screenTime")

        if let data = sharedDefaults?.data(forKey: "shared_restrictions") {
            do {
                let decoded = try JSONDecoder().decode([Restriction].self, from: data)
                print("✅ Restrictions récupérées dans le widget : \(decoded)")
                return decoded
            } catch {
                print("❌ Erreur de décodage des restrictions dans le widget : \(error)")
            }
        } else {
            print("❌ Aucune donnée trouvée dans UserDefaults pour 'shared_restrictions'")
        }

        return []
    }
}

struct TimeTracerWidgetEntryView: View {
    var entry: ScreenTimeEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Temps d’écran aujourd’hui")
                .font(.caption)
                .foregroundColor(.gray)

            Text(entry.screenTime)
                .font(.title2)
                .bold()

            Divider()

            Text("Restrictions")
                .font(.caption)
                .padding(.top, 4)

            ForEach(Array(entry.restrictions.prefix(2))) { restriction in
                Text("• \(restriction.name)(\(restriction.duration / 60) min)")
                    .font(.caption2)
            }

            Spacer()
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct TimeTracerWidget: Widget {
    let kind: String = "TimeTracerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TimeTracerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Temps d’écran")
        .description("Affiche le temps d’écran et deux restrictions.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct TimeTracerWidget_Previews: PreviewProvider {
    static var previews: some View {
        TimeTracerWidgetEntryView(entry: ScreenTimeEntry(date: Date(), screenTime: "1h 30min", restrictions: []))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
