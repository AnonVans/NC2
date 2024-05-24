//
//  WatchMealsLogging.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import SwiftUI

struct WatchMealsLogging: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            WatchBackground(color: Color.orange)
            
            VStack {
                Text("Do you want to log your meal?")
                    .font(.caption2)
                    .bold()
                    .foregroundStyle(Color.orange)
                    .padding(15)
                
                Button {
                    
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Log A Meal")
                    }
                    .font(.headline)
                    .bold()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.orange)
                .scaleEffect(0.8)
                .frame(width: 140, height: 40)
                .padding(10)
            }
        }
    }
}

#Preview {
    WatchMealsLogging()
}
