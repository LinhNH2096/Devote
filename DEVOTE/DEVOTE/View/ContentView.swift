//
//  ContentView.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 17/01/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var isShowInputTask: Bool = false
    
    // MARK: - Function
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // MARK: - Header
                    Spacer(minLength: 80)
                    
                    // MARK: - Add Task Button
                    Button {
                        isShowInputTask = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                    }
                    .padding(.vertical, 18)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(Capsule())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)

                    // MARK: - List Task
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.timestamp!, formatter: dateFormatter)")
                            } label: {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.task ?? "")
                                        .font(.headline)
                                    Text(item.timestamp!, formatter: dateFormatter)
                                        .font(.footnote)
                                        .foregroundColor(Color(UIColor.gray))
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    } //: List
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } //: VStack
                
                // MARK: - New Task Input View
                if isShowInputTask {
                    BlankView()
                        .onTapGesture {
                            withAnimation {
                                isShowInputTask = false
                            }
                        }
                    
                    NewTaskInputView(isShowing: $isShowInputTask)
                }
            } //: ZStack
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
            })
            .navigationBarTitle("Daily Task", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
            
        } //: NavigationView
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
