//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Nguyễn Hồng Lĩnh on 11/02/2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DevoteWidgetEntryView : View {
    // MARK: - Properties
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    var fontStyle: Font {
        switch widgetFamily {
        case .systemSmall: return Font.system(.footnote)
        default: return Font.system(.headline)
        }
    }

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    if widgetFamily == .systemSmall {
                        Text(entry.date, style: .time)
                            .foregroundColor(.white)
                            .font(fontStyle)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(
                                Color.white
                                    .opacity(0.5)
                                    .blendMode(.overlay)
                            )
                            .clipShape(Capsule())
                    }
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .frame(width: widgetFamily == .systemSmall ? 36 : 56,
                               height:  widgetFamily == .systemSmall ? 36 : 56)
                       
                       
                } //: HSTACK
                
                .offset(y: (geometry.size.height / -2) + (widgetFamily == .systemSmall ? 28 : 40))
                .padding(.horizontal, widgetFamily == .systemSmall ? 8 : 12)
                HStack {
                    Text("Just do it")
                        .foregroundColor(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(
                            Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                .blendMode(.overlay)
                        )
                        .clipShape(Capsule())
                    
                    if widgetFamily != .systemSmall {
                        Spacer()
                        Text(entry.date, style: .time)
                            .foregroundColor(.white)
                            .font(fontStyle)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(
                                Color.white
                                    .opacity(0.5)
                                    .blendMode(.overlay)
                            )
                            .clipShape(Capsule())
                    }
                    
                }//: HSTACK
                .padding()
                .offset(y: (geometry.size.height / 2) - 24)
            }//: ZSTACK
        }//: GEOMETRY
    }
}

@main
struct DevoteWidget: Widget {
    let kind: String = "DevoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Devote Launcher")
        .description("This is an example widget for personal task manager app.")
    }
}

struct DevoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
