//
//  HealthStoreChecker.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import SwiftUI

struct HealthStoreChecker: View {
    @EnvironmentObject var healthManager: HealthDataManager
    
    var body: some View {
        VStack {
            Text("Water: \(healthManager.water)")
            Text("Calories: \(healthManager.calories)")
            Text("Sleep: \(healthManager.sleep)")
            Text("HRV: \(healthManager.hrv)")
            
            Button("Refresh Health Data"){
                healthManager.fetchAllData()
            }
        }
        .padding()
    }
}

#Preview {
    HealthStoreChecker()
}
