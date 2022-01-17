//
//  DEVOTEApp.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 17/01/2022.
//

import SwiftUI

@main
struct DEVOTEApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
