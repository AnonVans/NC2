//
//  WatchBackground.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import SwiftUI

struct WatchBackground: View {
    var color: Color
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.clear, color], startPoint: .top, endPoint: .bottom)
                .opacity(0.25)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WatchBackground(color: .orange)
}
