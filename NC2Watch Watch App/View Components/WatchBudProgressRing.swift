//
//  WatchBudProgressRing.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import SwiftUI

struct WatchBudProgressRing: View {
    @EnvironmentObject var healthManager: HealthDataManager
    var homeViewModel: WatchHomeViewModel
    
    var frameHeightInner: Double
    var lineWidth: Double
    
    var body: some View {
        ZStack {
            Image(homeViewModel.fetchBudImageName())
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: frameHeightInner - (lineWidth * 1.5), height: frameHeightInner - (lineWidth * 1.5))
                .foregroundColor(homeViewModel.colorScheme)
            
            Circle()
                .stroke(lineWidth: lineWidth)
                .frame(height: frameHeightInner)
                .opacity(0.25)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(homeViewModel.calculateBudProgress(), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightInner)
                .foregroundColor(homeViewModel.colorScheme)
                .rotationEffect(.degrees(-90))
        }
    }
}

#Preview {
    WatchBudProgressRing(
        homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager(), budItems: []),
        frameHeightInner: 120,
        lineWidth: 7.5)
}
