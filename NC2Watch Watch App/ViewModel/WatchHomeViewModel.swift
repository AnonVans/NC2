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

    @ObservedObject var foodItemViewModel: WatchBudItemViewModel
    @ObservedObject var energyItemViewModel: WatchBudItemViewModel
    @ObservedObject var waterItemViewModel: WatchBudItemViewModel
    
    @Published var progress: Double = 0.25
    @Published var score: Int = 0
    @Published var bud: WatchBuds?
    var colorScheme = Color.yellowishGreen
    
    init (healthManager: HealthDataManager) {
        self.healthManager = healthManager
        
        foodItemViewModel = WatchBudItemViewModel(itemType: BudItemType.Food, healthManager: healthManager)
        energyItemViewModel = WatchBudItemViewModel(itemType: BudItemType.ActiveEnergy, healthManager: healthManager)
        waterItemViewModel = WatchBudItemViewModel(itemType: BudItemType.Water, healthManager: healthManager)
        
        self.bud = initializeBud()
    }
    
    func initializeBud() -> WatchBuds {
        switch true {
            case score < 0, (0...99).contains(score):
                return initializeBudByType(BudTypes.Sprout)
            case (100...199).contains(score):
                return initializeBudByType(BudTypes.Sapling)
            case (200...299).contains(score):
                return initializeBudByType(BudTypes.YoungTree)
            case (300...399).contains(score):
                return initializeBudByType(BudTypes.AdultTree)
            default:
                return initializeBudByType(BudTypes.PeakSeason)
        }
    }
    
    func initializeBudByType(_ budType: BudTypes) -> WatchBuds {
        switch budType {
        case .Sprout:
            return WatchBuds(type: BudTypes.Sprout, state: BudState.Normal)
        case .Sapling:
            return WatchBuds(type: BudTypes.Sapling, state: BudState.Normal)
        case .YoungTree:
            return WatchBuds(type: BudTypes.YoungTree, state: BudState.Normal)
        case .AdultTree:
            return WatchBuds(type: BudTypes.AdultTree, state: BudState.Normal)
        case .PeakSeason:
            return WatchBuds(type: BudTypes.PeakSeason, state: BudState.Normal)
        }
    }
    
    func calculateBudScore() {
        
    }
    
    func calculateBudProgress() {
        
    }
    
    func fetchBudImageName() -> String {
        return bud!.type.rawValue + bud!.state.rawValue
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
