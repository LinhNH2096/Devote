//
//  Utility.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 19/01/2022.
//

import Foundation
import SwiftUI

// MARK: - Date Formatter
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI
var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
}

// MARK: - UX

var feedback = UINotificationFeedbackGenerator()
