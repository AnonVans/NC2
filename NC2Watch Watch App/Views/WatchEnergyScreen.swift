//
//  WatchEnergyScreen.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import SwiftUI

struct WatchEnergyScreen: View {
    @EnvironmentObject var healthManager: HealthDataManager
    
    var homeViewModel: WatchHomeViewModel
//    var itemViewModel: WatchBudItemViewModel
    
    var body: some View {
        ZStack {
            WatchBackground(color: homeViewModel.energyItemViewModel.budItem!.colorScheme)
            
            VStack {
                HStack {
                    ZStack {
                        WatchBudProgressRing(homeViewModel: homeViewModel, frameHeightInner: 21.5, lineWidth: 2.5)
                        
                        WatchOuterBudRing(homeViewModel: homeViewModel, budItemType: BudItemType.ActiveEnergy, frameHeightOutter: 28.5, lineWidth: 2.5)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, -15)
                    
                    Spacer()
                }
                
                VStack {
                    WatchProgressRing(itemViewModel: homeViewModel.energyItemViewModel, progressFrameSize: 115, imageFrameSize: 75, lineWidth: 7.5, inHomeScreen: false)
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text(String(format: "%.1f", homeViewModel.energyItemViewModel.fetchProgressAmount()) + " kcal")
                                .font(.caption2)
                                .bold()
                                .foregroundStyle(homeViewModel.energyItemViewModel.budItem!.colorScheme)
                            Text(String(Int((homeViewModel.energyItemViewModel.calculateItemProgress()/0.75) * 100)) + "% burned")
                                .font(.caption2)
                        }
                    }
                    .padding()
                }
            }
            .frame(width: 165, height: 165)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                homeViewModel.energyItemViewModel.changeViewDisplay()
            }
        }
    }
}

#Preview {
    WatchEnergyScreen(homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager(), budItems: []))
}
