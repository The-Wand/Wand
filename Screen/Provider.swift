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

import Wand

struct Pickaxe: Identifiable {

    let id: Int

}

struct Provider: AppIntentTimelineProvider {

    let pickaxes: [Pickaxe] = [Pickaxe(id: 0)]

    let placeholderIntent = ConfigurationAppIntent(id: 0)

    func recommendations() -> [AppIntentRecommendation<ConfigurationAppIntent>] {
        var recommendations = [AppIntentRecommendation<ConfigurationAppIntent>]()

        pickaxes | {
            let intent = ConfigurationAppIntent(id: $0.id)
            recommendations.append(AppIntentRecommendation(intent: intent, description: "Pickaxe"))
        } as Void

        return recommendations
    }

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: placeholderIntent)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

extension Provider: TimelineProvider {

    func getSnapshot(in context: Context, completion: @escaping @Sendable (SimpleEntry) -> Void) {
        let snapshot = snapshot(for: placeholderIntent, in: context)
        completion(snapshot)
    }

    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<SimpleEntry>) -> Void) {
        let timeline = timeline(for: placeholderIntent, in: context)
        completion(timeline)
    }

}
