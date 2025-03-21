//
//  TimeTracerWidgetBundle.swift
//  TimeTracerWidget
//
//  Created by rose matheo on 21/03/2025.
//

import WidgetKit
import SwiftUI

@main
struct TimeTracerWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimeTracerWidget()
        TimeTracerWidgetLiveActivity()
    }
}
