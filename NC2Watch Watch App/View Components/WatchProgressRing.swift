//
//  SwiftUIView.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import SwiftUI

struct WatchProgressRing: View {
    @ObservedObject var itemViewModel: WatchBudItemViewModel
    
    var progressFrameSize: Double
    var imageFrameSize: Double
    var lineWidth: Double
    var inHomeScreen: Bool
    
    var body: some View {
        ZStack {
            if itemViewModel.changeDisplay && !inHomeScreen {
                VStack {
                    Text(itemViewModel.fetchRemainingAmountString())
                        .font(.headline)
                        .bold()
                        .foregroundStyle(itemViewModel.budItem!.colorScheme)
                    Text("remaining")
                        .font(.caption)
                }
                .frame(height: 115)
            } else {
                Image(systemName: itemViewModel.budItem!.imageName )
                    .font(.system(size: imageFrameSize))
                    .foregroundColor(itemViewModel.budItem!.colorScheme)
                    .offset(y: lineWidth)
            }
            
            Circle()
                .trim(from: 0.0, to: 0.75)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: progressFrameSize)
                .opacity(0.25)
                .foregroundColor(.gray)
                .rotationEffect(.degrees(135))
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(itemViewModel.calculateItemProgress(), 0.75)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: progressFrameSize)
                .foregroundColor(itemViewModel.budItem!.colorScheme)
                .rotationEffect(.degrees(-225))
        }
//        .frame(height: 125)
    }
}

#Preview {
    WatchProgressRing(itemViewModel: WatchBudItemViewModel(itemType: BudItemType.Food, healthManager: HealthDataManager(), budItemData: []), progressFrameSize: 115, imageFrameSize: 75, lineWidth: 7.5, inHomeScreen: false)
}
