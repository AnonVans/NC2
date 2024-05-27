//
//  WatchWaterScreen.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import SwiftUI

struct WatchWaterScreen: View {
    @EnvironmentObject var healthManager: HealthDataManager
    
    var homeViewModel: WatchHomeViewModel
//    var itemViewModel: WatchBudItemViewModel
    
    var body: some View {
        ZStack {
            WatchBackground(color: homeViewModel.waterItemViewModel.budItem!.colorScheme)
            
            VStack {
                HStack {
                    ZStack {
                        WatchBudProgressRing(homeViewModel: homeViewModel, frameHeightInner: 21.5, lineWidth: 2.5)
                        
                        WatchOuterBudRing(homeViewModel: homeViewModel, budItemType: BudItemType.Water, frameHeightOutter: 28.5, lineWidth: 2.5)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, -15)
                    
                    Spacer()
                }
                
                VStack {
                    WatchProgressRing(itemViewModel: homeViewModel.waterItemViewModel, progressFrameSize: 115, imageFrameSize: 75, lineWidth: 7.5, inHomeScreen: false)
                    
                    HStack {
                        HStack {
                            Text(String(Int(homeViewModel.waterItemViewModel.fetchProgressAmount())) + " ml")
                                .font(.caption)
                                .bold()
                                .foregroundStyle(homeViewModel.waterItemViewModel.budItem!.colorScheme)
                            Text(String(Int((homeViewModel.waterItemViewModel.calculateItemProgress()/0.75) * 100)) + "%")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: WatchWaterLogging(drinkViewModel: WatchDrinkViewModel(healthManager: healthManager), drinkItem: homeViewModel.waterItemViewModel)) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(homeViewModel.waterItemViewModel.budItem!.colorScheme)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 12)
                    
                }
            }
            .frame(width: 165, height: 165)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                homeViewModel.waterItemViewModel.changeViewDisplay()
            }
        }
    }
}

#Preview {
    WatchWaterScreen(
        homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager(), budItems: []))
}
