//
//  NC2App.swift
//  NC2
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import SwiftUI

@main
struct NC2App: App {
    @StateObject var healthManager = HealthDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(healthManager)
    }
}
