///
/// Copyright 2569 Aleksander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Aleksander Kozin
/// The Wand

import SwiftUI
import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct ScreenEntryView : View {
    var entry: Provider.Entry

    let pickAxe = "https://deeprockgalactic.wiki.gg/images/thumb/GearGraphic_PickAxe.png/600px-GearGraphic_PickAxe.png?8d8b42"

    var body: some View {
        VStack {
            Image(systemName: "wand.and.stars")
            Text("Hello, Wand|")
        }
    }

}

struct Screen: Widget {

    let kind: String = "com.the-wand.Screen"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: ConfigurationAppIntent.self,
                               provider: Provider()) { entry in
            ScreenEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }

}

extension ConfigurationAppIntent {

    fileprivate
    static
    var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate
    static
    var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }

}
#if os(iOS)
#Preview(as: .systemMedium) {
    Screen()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
#endif
