//
//  WatchWaterLogging.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import SwiftUI

struct WatchWaterLogging: View {
    @Environment(\.dismiss) var dismiss
    
    var drinkViewModel: WatchDrinkViewModel
    @State var hundred: Int = 1
    @State var ten: Int = 0
    
    var body: some View {
        ZStack {
            WatchBackground(color: Color.blue)
            
            VStack {
                HStack(alignment: .center) {
                    Picker("", selection: $hundred) {
                        ForEach(drinkViewModel.getHundreds(), id:\.self) {
                            Text(String($0))
                                .font(.headline)
                                .scaleEffect(1.25)
                                .foregroundStyle(Color.blue)
                        }
                    }
                    
                    Picker("", selection: $ten) {
                        ForEach(drinkViewModel.getTens(), id:\.self) {
                            Text($0 == 0 ? "00" : String($0))
                                .font(.headline)
                                .scaleEffect(1.25)
                                .foregroundStyle(Color.blue)
                        }
                    }
                    
                    Text("ml")
                        .font(.headline)
                        .scaleEffect(1.25)
                        .foregroundStyle(Color.blue)
                        .offset(y: 6)
                        .padding(5)
                }
                .frame(width: 125, height: 100)
                .padding(10)
                
                Button {
                    drinkViewModel.writeToHealthKit(hundred, ten)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Log Water")
                    }
                    .font(.caption2)
                    .bold()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.blue)
                .scaleEffect(0.75)
                .frame(width: 120, height: 25)
                .padding(10)
            }
        }
        .onDisappear{
            dismiss()
        }
    }
}

#Preview {
    WatchWaterLogging(drinkViewModel: WatchDrinkViewModel(healthManager: HealthDataManager()))
}
