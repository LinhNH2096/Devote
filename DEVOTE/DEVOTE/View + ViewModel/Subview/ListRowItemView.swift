//
//  ListRowItemView.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 04/02/2022.
//

import SwiftUI

struct ListRowItemView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) var viewContext
    @StateObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? .pink : .primary)
                .padding(.vertical, 12)
                .animation(.default)
        } //: TOGGLE
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange) { _ in // when the item object change, we check whether viewContext has changed and save new context, cause item object is a persistence object of Core Data that make viewContext change
            if viewContext.hasChanges {
                try? viewContext.save()
            }
        }
    }
}


struct ListRowItemView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
