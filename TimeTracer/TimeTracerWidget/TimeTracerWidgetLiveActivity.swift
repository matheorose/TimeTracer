//
//  TimeTracerWidgetLiveActivity.swift
//  TimeTracerWidget
//
//  Created by rose matheo on 21/03/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimeTracerWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TimeTracerWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeTracerWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TimeTracerWidgetAttributes {
    fileprivate static var preview: TimeTracerWidgetAttributes {
        TimeTracerWidgetAttributes(name: "World")
    }
}

extension TimeTracerWidgetAttributes.ContentState {
    fileprivate static var smiley: TimeTracerWidgetAttributes.ContentState {
        TimeTracerWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TimeTracerWidgetAttributes.ContentState {
         TimeTracerWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TimeTracerWidgetAttributes.preview) {
   TimeTracerWidgetLiveActivity()
} contentStates: {
    TimeTracerWidgetAttributes.ContentState.smiley
    TimeTracerWidgetAttributes.ContentState.starEyes
}
