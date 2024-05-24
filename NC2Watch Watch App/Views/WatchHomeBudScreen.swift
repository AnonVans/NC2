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
            
            WatchBudProgressRing(homeViewModel: homeViewModel, budItemType: nil, imageSize: 75.0, frameHeightInner: 112.5, frameHeightOutter: 142.5, lineWidth: 7.5)
        }
    }
}

#Preview {
    WatchHomeBudScreen(homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager()))
}
