//
//  NC2WatchApp.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import SwiftUI
import SwiftData

@main
struct NC2Watch_Watch_AppApp: App {
    @StateObject var healthManager = HealthDataManager()
    @StateObject var iosConnector = IOSAppConnector()
    
    var body: some Scene {
        WindowGroup {
            ContentView(receivedData: $iosConnector.receivedData, didReceiveData: $iosConnector.didReceiveData)
                .environmentObject(healthManager)
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [
            WatchBudModelData.self
        ])
    }
}
