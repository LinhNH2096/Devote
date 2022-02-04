//
//  BlankView.swift
//  DEVOTE
//
//  Created by Nguyễn Hồng Lĩnh on 19/01/2022.
//

import SwiftUI

struct BlankView: View {
    // MARK: - Properties
    var backgroundColor: Color
    var opacity: Double
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(opacity)
        .blendMode(.overlay)
        .ignoresSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: .black, opacity: 0.8)
            .background(BackgroundImageView())
            .ignoresSafeArea()
    }
}
