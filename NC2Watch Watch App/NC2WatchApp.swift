//
//  NC2WatchApp.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import SwiftUI

@main
struct NC2Watch_Watch_AppApp: App {
    @StateObject var healthManager = HealthDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(homeViewModel: WatchHomeViewModel(healthManager: healthManager))
                .environmentObject(healthManager)
                .preferredColorScheme(.dark)
        }
    }
}
