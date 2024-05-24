//
//  WatchDrinkViewModel.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import Foundation

class WatchDrinkViewModel {
    var healthManager: HealthDataManager
    
    private var hundreds = [Int]()
    private var tens = [Int]()
    
    init(healthManager: HealthDataManager) {
        hundreds = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        tens = [0, 25, 50, 75]
        
        self.healthManager = healthManager
    }
    
    func getHundreds() -> [Int] {
        return self.hundreds
    }
    
    func getTens() -> [Int] {
        return self.tens
    }
    
    func writeToHealthKit(_ hundred: Int, _ ten: Int) {
        let waterIntake = (hundred * 100) + ten
        
        healthManager.sendWaterIntake(waterIntake)
    }
}
