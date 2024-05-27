//
//  NC2App.swift
//  NC2
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import SwiftUI
import SwiftData

@main
struct NC2App: App {
    @StateObject var healthManager = HealthDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(healthManager)
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [
            BudDataModel.self
        ])
    }
}
