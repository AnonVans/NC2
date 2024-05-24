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
    
    var budItemType: BudItemType?
    var imageSize: Double
    var frameHeightInner: Double
    var frameHeightOutter: Double
    var lineWidth: Double
    
    var body: some View {
        ZStack {
            Image(systemName: homeViewModel.budState!.imageName)
                .font(.system(size: imageSize))
                .foregroundColor(homeViewModel.colorScheme)
            
            Circle()
                .stroke(lineWidth: lineWidth)
                .frame(height: frameHeightInner)
                .opacity(0.25)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(homeViewModel.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightInner)
                .foregroundColor(homeViewModel.colorScheme)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: 0.0, to: 0.3)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightOutter)
                .rotationEffect(.degrees(-84))
                .opacity(0.25)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(homeViewModel.foodItemViewModel.calculateItemBudProgress(), 0.3)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightOutter)
                .rotationEffect(.degrees(-84))
                .foregroundColor(homeViewModel.foodItemViewModel.budItem!.colorScheme)
                .opacity((budItemType == BudItemType.Food) || (budItemType == nil) ? 1 : 0.25)
            
            Circle()
                .trim(from: 0.0, to: 0.3)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightOutter)
                .rotationEffect(.degrees(36))
                .opacity(0.25)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(homeViewModel.energyItemViewModel.calculateItemBudProgress(), 0.3)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightOutter)
                .rotationEffect(.degrees(36))
                .foregroundColor(homeViewModel.energyItemViewModel.budItem!.colorScheme)
                .opacity((budItemType == BudItemType.ActiveEnergy) || (budItemType == nil) ? 1 : 0.25)
            
            Circle()
                .trim(from: 0.0, to: 0.3)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightOutter)
                .rotationEffect(.degrees(156))
                .opacity(0.25)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(homeViewModel.waterItemViewModel.calculateItemBudProgress(), 0.3)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(height: frameHeightOutter)
                .rotationEffect(.degrees(156))
                .foregroundColor(homeViewModel.waterItemViewModel.budItem!.colorScheme)
                .opacity((budItemType == BudItemType.Water) || (budItemType == nil) ? 1 : 0.25)
        }
    }
}

#Preview {
    WatchBudProgressRing(
        homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager()),
        budItemType: nil, imageSize: 75.0,
        frameHeightInner: 112.5,
        frameHeightOutter: 142.5,
        lineWidth: 7.5)
}
