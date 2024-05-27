//
//  WatchHomeScreen.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import SwiftUI

struct WatchHomeBudScreen: View {
    @EnvironmentObject var healthManager: HealthDataManager
    @ObservedObject var homeViewModel: WatchHomeViewModel
    
    var body: some View {
        ZStack {
            WatchBackground(color: homeViewModel.colorScheme)
            
            VStack {
                HStack {
                    WatchProgressRing(itemViewModel: homeViewModel.fetchEnergyItem(), progressFrameSize: 35, imageFrameSize: 22.5, lineWidth: 3, inHomeScreen: true)
                        .padding(.horizontal, 10)
                        .padding(.vertical, -15)
                    
                    Spacer()
                }
                
                WatchBudProgressRing(homeViewModel: homeViewModel, frameHeightInner: 115, lineWidth: 7.5)
                    .padding(5)
                
                HStack {
                    WatchProgressRing(itemViewModel: homeViewModel.fetchFoodItem(), progressFrameSize: 35, imageFrameSize: 22.5, lineWidth: 3, inHomeScreen: true)
                    
                    Spacer()
                    
                    WatchProgressRing(itemViewModel: homeViewModel.fetchWaterItem(), progressFrameSize: 35, imageFrameSize: 22.5, lineWidth: 3, inHomeScreen: true)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, -15)
            }
        }
    }
}

#Preview {
    WatchHomeBudScreen(homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager(), budItems: []))
}
