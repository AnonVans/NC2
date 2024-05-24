//
//  ContentView.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthManager: HealthDataManager
    
    @StateObject var homeViewModel: WatchHomeViewModel
    
    var body: some View {
        VStack {
            TabView {
                NavigationStack {
                    HealthStoreChecker()
                }
                NavigationStack {
                    WatchHomeBudScreen(homeViewModel: homeViewModel)
                }
                NavigationStack {
                    WatchFoodScreen(homeViewModel: homeViewModel, itemViewModel: homeViewModel.fetchFoodItem())
                }
                NavigationStack {
                    WatchEnergyScreen(homeViewModel: homeViewModel, itemViewModel: homeViewModel.fetchEnergyItem())
                }
                NavigationStack {
                    WatchWaterScreen(homeViewModel: homeViewModel, itemViewModel: homeViewModel.fetchWaterItem())
                }
            }
            .tabViewStyle(.verticalPage(transitionStyle: .blur))
        }
        .onAppear {
            healthManager.fetchAllData()
        }
    }
}

#Preview {
    ContentView(homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager()))
}
