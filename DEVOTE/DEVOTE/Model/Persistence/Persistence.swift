//
//  Persistence.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 17/01/2022.
//

import CoreData
import SwiftUI

struct PersistenceController {
    // MARK: - Persistence Controller
    static let shared = PersistenceController()
    
    // MARK: - Persistence Container
    let container: NSPersistentContainer

    // MARK: - Initialization (Load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DEVOTE")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.task = "Task No.\(i)"
            newItem.completion = false
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}

struct Persistence_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
