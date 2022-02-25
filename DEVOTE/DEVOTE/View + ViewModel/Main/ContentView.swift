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
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)], animation: .default) var items: FetchedResults<Item>
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State var isShowInputTask: Bool = false
    
    // MARK: - Function
    func deleteItems(offsets: IndexSet) {
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
                // MARK: - Main View
                VStack {
                    // MARK: - Header
                    HStack(spacing: 10) {
                        // Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // Edit Button
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        // Appearance Button
                        Button {
                            isDarkMode.toggle()
                            playSound(soundName: "sound-tap")
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                        
                    } //: HStack
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
                    // MARK: - Add Task Button
                    Button {
                        isShowInputTask = true
                        playSound(soundName: "sound-ding")
                        
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
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } //: List
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } //: VStack
                .blur(radius: isShowInputTask ? 0.8 : 0 , opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                // MARK: - New Task Input View
                if isShowInputTask {
                    BlankView(backgroundColor: isDarkMode ? .black : .gray,
                              opacity: isDarkMode ? 0.3 : 0.5)
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
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
                    .blur(radius: isShowInputTask ? 0.8 : 0, opaque: false)
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
