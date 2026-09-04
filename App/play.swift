///
/// Copyright 2020 Aleksander Kozin
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

import Wand

@available(iOS 18, macOS 15, tvOS 14, watchOS 7, *)
@main
struct PlayApp: App {
    
#if canImport(UIKit)
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#else
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
    
    var body: some Scene {
        WindowGroup {
            BotView()
        }
#if os(macOS)
        .restorationBehavior(.automatic)
        .windowResizability(.contentSize)
#endif
    }
    
}

@available(iOS 18, macOS 15, tvOS 14, watchOS 7, *)
struct BotView: View {
    
    private
    let width: CGFloat = 78
    private
    let height: CGFloat = 78 - 17
    
    private
    let size = CGSize(width: 78, height: 78 - 17)
    
    private
    let expanding = CGSize(width: 200, height: 300)
    
    
    private
    let bot = Core()
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                    //                .blur(radius: 12)
                        .frame(width: size.width,
                               height: size.height)
                        .foregroundColor(.accentColor)
                    
                    VStack {
                        Image(systemName: "wand.and.stars")
                        Text((bot.wand.name.remainder| as Character)|)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .onAppear {
            //Wand.Log.level = .verbose
            
        }
        .frame(minWidth: size.width,
               maxWidth: expanding.width,
               minHeight: size.height,
               maxHeight: expanding.height
        )
#if os(macOS)
        .allowsWindowActivationEvents(true)
        .gesture(WindowDragGesture())
        .toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
        .toolbar(removing: .title)
        
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification), perform: { _ in
            
            guard let window = NSApp.mainWindow else {
                return
            }
            
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        })
#endif
    }
    
}

@available(iOS 18, macOS 15, tvOS 14, watchOS 7, *)
#Preview {
    BotView()
}
