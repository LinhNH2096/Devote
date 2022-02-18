//
//  CheckBoxStyle.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 04/02/2022.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    configuration.isOn ? playSound(soundName: "sound-rise") : playSound(soundName: "sound-tap")
                }
            
            configuration.label
        } //: HSTACK
    }
}

struct CheckBoxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("New Task", isOn: .constant(true))
            .toggleStyle(CheckBoxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
