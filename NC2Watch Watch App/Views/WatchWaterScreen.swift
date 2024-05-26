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
    var itemViewModel: WatchBudItemViewModel
    
    var body: some View {
        ZStack {
            WatchBackground(color: itemViewModel.budItem!.colorScheme)
            
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
                    WatchProgressRing(itemViewModel: itemViewModel, progressFrameSize: 115, imageFrameSize: 75, lineWidth: 7.5)
                    
                    HStack {
                        HStack {
                            Text(String(Int(itemViewModel.fetchProgressAmount())) + " ml")
                                .font(.caption)
                                .bold()
                                .foregroundStyle(itemViewModel.budItem!.colorScheme)
                            Text(String(Int((itemViewModel.progress/0.75) * 100)) + "%")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: WatchWaterLogging(drinkViewModel: WatchDrinkViewModel(healthManager: healthManager))) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(itemViewModel.budItem!.colorScheme)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 12)
                    
                }
            }
            .frame(width: 165, height: 165)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                itemViewModel.changeViewDisplay()
            }
        }
    }
}

#Preview {
    WatchWaterScreen(
        homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager()), itemViewModel: WatchBudItemViewModel(itemType: BudItemType.Water, healthManager: HealthDataManager()))
}
