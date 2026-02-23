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


struct PickaxeWidget: Widget {

    let kind: String = "com.the-wand.Pickaxe"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) {
            ScreenEntryView(entry: $0)
        }
        .configurationDisplayName("Pickaxe")
        .description("Shows the current selected core skin.")
        .supportedFamilies([.accessoryCorner, .accessoryCircular, .accessoryInline])
    }

}

struct PickaxeComplicationView: View {

    // Get the widget's family.
    @Environment(\.widgetFamily) private var family

    var entry: Provider.Entry

    var body: some View {
        switch family {
            case .accessoryCircular:
                MyCircularComplication(mgCaffeine: entry.mgCaffeine,
                                       totalCups: entry.totalCups)

            case .accessoryCorner:
                MyCornerComplication(mgCaffeine: entry.mgCaffeine,
                                     totalCups: entry.totalCups)

            case .accessoryInline:
                MyInlineComplication(mgCaffeine: entry.mgCaffeine,
                                     totalCups: entry.totalCups)

            default:
                Image("AppIcon")
        }
    }
}
