//
//  WatchProgressItemViewModel.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import Foundation
import SwiftUI

class WatchBudItemViewModel: ObservableObject {
    var healthManager: HealthDataManager

    @Published var progress: Double = 0.25
    @Published var changeDisplay = false
    var budItem: WatchBudItem?
    var budItemType: BudItemType
    
    init(itemType: BudItemType, healthManager: HealthDataManager) {
        self.budItemType = itemType
        self.healthManager = healthManager
        self.budItem = initializeBudItem(itemType)
        
        calculateItemProgress()
    }
    
    func initializeBudItem(_ itemType: BudItemType) -> WatchBudItem {
        switch itemType {
        case .Food:
            return WatchBudItem(type: BudItemType.Food, imageName: "fork.knife", colorScheme: Color.warmOrange, counter: 1, target: 3)
        case .ActiveEnergy:
            return WatchBudItem(type: BudItemType.ActiveEnergy, imageName: "flame.fill", colorScheme: Color.brightRed, counter: 0, target: 250)
        case .Water:
            return WatchBudItem(type: BudItemType.Water, imageName: "waterbottle.fill", colorScheme: Color.greenishCyan, counter: 0, target: 2000)
        }
    }
    
    func calculateItemProgress() {
        switch budItem!.type {
        case .Food:
            self.progress = (Double(budItem!.counter)/budItem!.target) * 0.75
        case .ActiveEnergy:
            self.progress = (healthManager.calories/budItem!.target) * 0.75
        case .Water:
            self.progress = (Double(healthManager.water)/budItem!.target) * 0.75
        }
    }
    
    func calculateItemBudProgress() -> Double {
        switch budItem!.type {
        case .Food:
            return (Double(budItem!.counter)/budItem!.target) * 0.3
        case .ActiveEnergy:
            return (healthManager.calories/budItem!.target) * 0.3
        case .Water:
            return (Double(healthManager.water)/budItem!.target) * 0.3
        }
    }
    
    func fetchProgressAmount() -> Double {
        switch budItem!.type {
        case .Food:
            return Double(budItem!.counter)
        case .ActiveEnergy:
            return healthManager.calories
        case .Water:
            return Double(healthManager.water)
        }
    }
    
    func fetchRemainingAmount() -> Double {
        switch budItem!.type {
        case .Food:
            return budItem!.target - Double(budItem!.counter)
        case .ActiveEnergy:
            return budItem!.target - healthManager.calories
        case .Water:
            return budItem!.target - Double(healthManager.water)
        }
    }
    
    func fetchTypeUnits() -> String {
        switch budItem!.type {
        case .Food:
            return " meals"
        case .ActiveEnergy:
            return " kcal"
        case .Water:
            return " ml"
        }
    }
    
    func fetchRemainingAmountString() -> String {
        switch budItem!.type {
        case .Food, .Water:
            return String(Int(fetchRemainingAmount())) + fetchTypeUnits()
        case .ActiveEnergy:
            return String(format: "%.1f", fetchRemainingAmount()) + fetchTypeUnits()
        }
    }
    
    func changeViewDisplay() {
        changeDisplay.toggle()
    }
    
}
