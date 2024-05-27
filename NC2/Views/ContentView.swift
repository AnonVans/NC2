//
//  ContentView.swift
//  NC2
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @EnvironmentObject var healthManager: HealthDataManager
    
    var body: some View {
        TabView {
            SettingScreen()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
            HealthStoreDataView()
                .tabItem {
                    Label("Data", systemImage: "doc.text")
                }
        }
        .padding()
        .onAppear {
            Task {
                await healthManager.fetchWater()
                await healthManager.fetchCalories()
                await healthManager.fetchSleep()
                await healthManager.fetchHRV()
            }
            
            Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                Task {
                    await healthManager.fetchWater()
                    await healthManager.fetchCalories()
                    await healthManager.fetchSleep()
                    await healthManager.fetchHRV()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
