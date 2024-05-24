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
        VStack {
            Text("Water: \(healthManager.water)")
            Text("Calories: \(healthManager.calories)")
            Text("Sleep: \(healthManager.sleep)")
            Text("HRV: \(healthManager.hrv)")
        }
        .padding()
        .onAppear {
            Task {
                await healthManager.fetchWater()
                await healthManager.fetchCalories()
                await healthManager.fetchSleep()
                await healthManager.fetchHRV()
            }
        }
    }
}

#Preview {
    ContentView()
}
