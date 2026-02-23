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

#if os(watchOS)
        .supportedFamilies([.accessoryCorner, .accessoryCircular, .accessoryInline])
#endif
    }

}

struct PickaxeComplicationView: View {

    // Get the widget's family.
    @Environment(\.widgetFamily) private var family

    var entry: Provider.Entry

    var body: some View {
        switch family {
//
//            case .systemSmall:
//                PickaxeCircularComplication(id: entry.configuration.id)

#if os(watchOS)
            case .accessoryCircular:
                PickaxeCircularComplication(id: entry.configuration.id)

            case .accessoryCorner:
                PickaxeCornerComplication(id: entry.configuration.id)

            case .accessoryInline:
                PickaxeInlineComplication(id: entry.configuration.id)
#endif
            default:
                PickaxeCircularComplication(id: entry.configuration.id)
        }
    }
}

struct PickaxeCircularComplication: View {

    @Environment(\.widgetRenderingMode)
    var renderingMode

    var id: Int

    var mgCaffeine: Double = 1
    var totalCups: Double = 2
    let maxMG = 500.0

    let formatter = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(2))

    var body: some View {
        Gauge( value: min(mgCaffeine, maxMG), in: 0.0...maxMG ) {
            Text("mg")
        } currentValueLabel: {
            if renderingMode == .fullColor {
                Text(mgCaffeine.formatted(formatter))
                    .foregroundStyle(
                        Color(hue: 0.5,
                              saturation: 0.5,
                              brightness: mgCaffeine
                             )
                    )
            }
            else {
                Text(mgCaffeine.formatted(formatter))
            }
        }
//        .gaugeStyle(
//            CircularGaugeStyle(
//                tint:
//                    Gradient(stops: [
//                        Gradient.Stop(color: .green, location: 0.0),
//                        Gradient.Stop(color: .cyan, location: 1.0)
//                    ])
//            )
//        )
    }
}

struct PickaxeCornerComplication: View {

    @Environment(\.widgetRenderingMode)
    var renderingMode

    var id: Int

    var mgCaffeine: Double = 1
    var totalCups: Double = 2
    let maxMG = 500.0

    let formatter = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(2))

    var body: some View {
        Gauge( value: min(mgCaffeine, maxMG), in: 0.0...maxMG ) {
            Text("mg")
        } currentValueLabel: {
            if renderingMode == .fullColor {
                Text(mgCaffeine.formatted(formatter))
                    .foregroundStyle(
                        Color(hue: 0.5,
                              saturation: 0.5,
                              brightness: mgCaffeine
                             )
                    )
            }
            else {
                Text(mgCaffeine.formatted(formatter))
            }
        }
//        .gaugeStyle(
//            CircularGaugeStyle(
//                tint:
//                    Gradient(stops: [
//                        Gradient.Stop(color: .green, location: 0.0),
//                        Gradient.Stop(color: .cyan, location: 1.0)
//                    ])
//            )
//        )
    }
}

struct PickaxeInlineComplication: View {

    @Environment(\.widgetRenderingMode)
    var renderingMode

    var id: Int

    var mgCaffeine: Double = 1
    var totalCups: Double = 2
    let maxMG = 500.0

    let formatter = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(2))

    var body: some View {
        Gauge( value: min(mgCaffeine, maxMG), in: 0.0...maxMG ) {
            Text("mg")
        } currentValueLabel: {
            if renderingMode == .fullColor {
                Text(mgCaffeine.formatted(formatter))
                    .foregroundStyle(
                        Color(hue: 0.5,
                              saturation: 0.5,
                              brightness: mgCaffeine
                             )
                    )
            }
            else {
                Text(mgCaffeine.formatted(formatter))
            }
        }
//        .gaugeStyle(
//            CircularGaugeStyle(
//                tint:
//                    Gradient(stops: [
//                        Gradient.Stop(color: .green, location: 0.0),
//                        Gradient.Stop(color: .cyan, location: 1.0)
//                    ])
//            )
//        )
    }
}
