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
    let restrictions: [String]
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ScreenTimeEntry {
        ScreenTimeEntry(date: Date(), screenTime: "1h 30min", restrictions: ["Pas TikTok", "Pas Insta"])
    }

    func getSnapshot(in context: Context, completion: @escaping (ScreenTimeEntry) -> Void) {
        let entry = ScreenTimeEntry(date: Date(), screenTime: "1h 30min", restrictions: ["Pas TikTok", "Pas Insta"])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ScreenTimeEntry>) -> Void) {
        let entry = ScreenTimeEntry(date: Date(), screenTime: "1h 30min", restrictions: ["Pas TikTok", "Pas Insta"])
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
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
                .foregroundColor(.gray)

            ForEach(entry.restrictions.prefix(2), id: \.self) { restriction in
                Text("• \(restriction)")
                    .font(.subheadline)
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
        TimeTracerWidgetEntryView(entry: ScreenTimeEntry(date: Date(), screenTime: "1h 30min", restrictions: ["Pas TikTok", "Pas Insta"]))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
