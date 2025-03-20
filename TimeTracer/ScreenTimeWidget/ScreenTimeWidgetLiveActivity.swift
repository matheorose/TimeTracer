//
//  ScreenTimeWidgetLiveActivity.swift
//  ScreenTimeWidget
//
//  Created by rose matheo on 20/03/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ScreenTimeWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ScreenTimeWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ScreenTimeWidgetAttributes.self) { context in
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

extension ScreenTimeWidgetAttributes {
    fileprivate static var preview: ScreenTimeWidgetAttributes {
        ScreenTimeWidgetAttributes(name: "World")
    }
}

extension ScreenTimeWidgetAttributes.ContentState {
    fileprivate static var smiley: ScreenTimeWidgetAttributes.ContentState {
        ScreenTimeWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ScreenTimeWidgetAttributes.ContentState {
         ScreenTimeWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ScreenTimeWidgetAttributes.preview) {
   ScreenTimeWidgetLiveActivity()
} contentStates: {
    ScreenTimeWidgetAttributes.ContentState.smiley
    ScreenTimeWidgetAttributes.ContentState.starEyes
}
