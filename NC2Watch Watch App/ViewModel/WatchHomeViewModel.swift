//
//  WatchHomeViewModel.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import Foundation
import SwiftUI

class WatchHomeViewModel: ObservableObject {
    var healthManager: HealthDataManager

    var foodItemViewModel: WatchBudItemViewModel
    var energyItemViewModel: WatchBudItemViewModel
    var waterItemViewModel: WatchBudItemViewModel
    
    var score: Double = 0.0
    var bud: WatchBuds?
    var colorScheme = Color.yellowishGreen
    var imageName: String = ""
    
    var budItems: [WatchBudModelData]
    
    init (healthManager: HealthDataManager, budItems: [WatchBudModelData]) {
        self.healthManager = healthManager
        self.budItems = budItems
        
        foodItemViewModel = WatchBudItemViewModel(itemType: BudItemType.Food, healthManager: healthManager, budItemData: budItems)
        energyItemViewModel = WatchBudItemViewModel(itemType: BudItemType.ActiveEnergy, healthManager: healthManager, budItemData: budItems)
        waterItemViewModel = WatchBudItemViewModel(itemType: BudItemType.Water, healthManager: healthManager, budItemData: budItems)
        
        self.bud = initializeBud()
        self.imageName = bud!.type.rawValue + bud!.state.rawValue
    }
    
    func initializeBud() -> WatchBuds {
        switch true {
            case calculateBudScore() < 100:
                return initializeBudByType(BudTypes.Sprout, BudState.Normal)
            case calculateBudScore() < 200 && calculateBudScore() >= 100:
                return initializeBudByType(BudTypes.Sapling, BudState.Normal)
            case calculateBudScore() < 300 && calculateBudScore() >= 200:
                return initializeBudByType(BudTypes.YoungTree, BudState.Normal)
            default:
                return initializeBudByType(BudTypes.AdultTree, BudState.Normal)
        }
    }
    
    func initializeBudByType(_ budType: BudTypes, _ budState: BudState) -> WatchBuds {
        return WatchBuds(type: budType, state: budState)
    }
    
    func calculateBudScore() -> Double {
        let foodItem = self.foodItemViewModel
        let foodScore = (Double(foodItem.budItem!.budItemData.counter) / foodItem.budItem!.budItemData.target) * 100
        
        let energyItem = self.waterItemViewModel
        let energyScore = (healthManager.calories / energyItem.budItem!.budItemData.target) * 100
        
        let waterItem = self.waterItemViewModel
        let waterScore = (Double(healthManager.water) / waterItem.budItem!.budItemData.target) * 100
        
        self.score = foodScore + energyScore + waterScore
//        self.score = Int(tempscore)
        
        return self.score
    }
    
    func calculateBudProgress() -> Double {
        let progressScore = Int(calculateBudScore()) % 100
        let progress = Double(progressScore) / 100
        
        return progress
    }
    
    func bloomingPhase() -> Bool {
        let foodItem = self.foodItemViewModel
        let foodScore = (foodItem.calculateItemBudProgress() / foodItem.budItem!.budItemData.target) * 100
        
        let energyItem = self.waterItemViewModel
        let energyScore = (energyItem.calculateItemBudProgress() / energyItem.budItem!.budItemData.target) * 100
        
        let waterItem = self.waterItemViewModel
        let waterScore = (waterItem.calculateItemBudProgress() / waterItem.budItem!.budItemData.target) * 100
        
        if self.score >= 400 {
            if foodScore > 100 && energyScore >= 100 && waterScore >= 100 {
                return true
            }
        }
        
        return false
    }
    
    func fetchBudImageName() -> String {
        if bloomingPhase() {
            self.bud = initializeBudByType(BudTypes.PeakSeason, BudState.Normal)
        } else {
            self.bud = initializeBud()
        }
        
        self.imageName = self.bud!.type.rawValue + self.bud!.state.rawValue
        return imageName
    }
    
    func fetchFoodItem() -> WatchBudItemViewModel {
        return self.foodItemViewModel
    }
    
    func fetchEnergyItem() -> WatchBudItemViewModel {
        return self.energyItemViewModel
    }
    
    func fetchWaterItem() -> WatchBudItemViewModel {
        return self.waterItemViewModel
    }
    
}
