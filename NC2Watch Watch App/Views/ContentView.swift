//
//  ContentView.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var healthManager: HealthDataManager
    @Environment(\.modelContext) var itemModel
    @Query var budItems: [WatchBudModelData]
    
//    @StateObject var homeViewModel = WatchHomeViewModel(healthManager: healthManager, budItems: budItems)
    
    @Binding var receivedData: [String : Any]
    @Binding var didReceiveData: Bool
    
    var body: some View {
        VStack {
            TabView {
                NavigationStack {
                    WatchHomeBudScreen(homeViewModel: WatchHomeViewModel(healthManager: healthManager, budItems: budItems))
                }
                NavigationStack {
                    WatchFoodScreen(homeViewModel: WatchHomeViewModel(healthManager: healthManager, budItems: budItems))
                }
                NavigationStack {
                    WatchEnergyScreen(homeViewModel: WatchHomeViewModel(healthManager: healthManager, budItems: budItems))
                }
                NavigationStack {
                    WatchWaterScreen(homeViewModel: WatchHomeViewModel(healthManager: healthManager, budItems: budItems))
                }
            }
            .tabViewStyle(.verticalPage(transitionStyle: .blur))
        }
        .onAppear {
            initDataModel()
            updateData()
            healthManager.fetchAllData()
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                healthManager.fetchAllData()
                updateData()
            }
        }
    }
    
    func initDataModel() {
        if budItems.isEmpty {
            let foodItem = WatchBudModelData(itemType: "Food", counter: 0, target: 3, timeStamp: Date())
            let energyItem = WatchBudModelData(itemType: "ActiveEnergy", counter: 0, target: 250, timeStamp: Date())
            let waterItem = WatchBudModelData(itemType: "Water", counter: 0, target: 2000, timeStamp: Date())
            
            itemModel.insert(foodItem)
            itemModel.insert(energyItem)
            itemModel.insert(waterItem)
        }
    }
    
    func updateData() {
        if didReceiveData {
            for budItem in budItems {
                if budItem.itemType == "Food" {
                    budItem.target = (receivedData["Food"] as? Double)!
                } else if budItem.itemType == "ActiveEnergy" {
                    budItem.target = (receivedData["ActiveEnergy"] as? Double)!
                } else if budItem.itemType == "Water" {
                    budItem.target = (receivedData["Water"] as? Double)!
                }
            }
        }
    }
    
}

//#Preview {
//    ContentView(homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager(), budItems: []))
//    ContentView(receivedData: [:])
//}
