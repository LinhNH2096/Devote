//
//  NewTaskInputView.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 19/01/2022.
//

import SwiftUI

struct NewTaskInputView: View {
    
    // MARK: - Properties
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var newTask: String = ""
    
    @Binding var isShowing: Bool
    
    private var isValidTask: Bool {
        !newTask.isEmpty
    }
    
    // MARK: - Function
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.task = newTask
            newItem.completion = false
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            newTask = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            // INPUT TASK
            VStack(spacing: 10) {
                TextField("New Task", text: $newTask)
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                
                Button {
                    addItem()
                    playSound(soundName: "sound-ding")
                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(!isValidTask)
                .onTapGesture {
                    if !isValidTask {
                        playSound(soundName: "sound-tap")
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(isValidTask ? Color.pink : Color.blue)
                .cornerRadius(10)
            }//: VStack
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(12)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
            
        }//: VStack
        .padding()
    }
}

struct NewTaskInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewTaskInputView(isShowing: .constant(true))
                .preferredColorScheme(.light)
        }
    }
}
