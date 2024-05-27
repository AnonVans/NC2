//
//  HealthStoreDataView.swift
//  NC2
//
//  Created by Stevans Calvin Candra on 27/05/24.
//

import SwiftUI

struct HealthStoreDataView: View {
    @EnvironmentObject var healthManager: HealthDataManager
    
    var body: some View {
        VStack {
            Text("Water: \(healthManager.water)")
            Text("Calories: \(healthManager.calories)")
            Text("Sleep: \(healthManager.sleep)")
            Text("HRV: \(healthManager.hrv)")
        }
    }
}

#Preview {
    HealthStoreDataView()
}
