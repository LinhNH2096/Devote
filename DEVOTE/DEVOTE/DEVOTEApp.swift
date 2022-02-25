//
//  DEVOTEApp.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 17/01/2022.
//

import SwiftUI
import UIKit

@main
struct DEVOTEApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
} 
