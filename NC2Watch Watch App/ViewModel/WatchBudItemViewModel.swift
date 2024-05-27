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

    @Published var changeDisplay = false
    var budItem: WatchBudItem?
    var budItemType: BudItemType
    
    var budItemData: [WatchBudModelData]
    
    init(itemType: BudItemType, healthManager: HealthDataManager, budItemData: [WatchBudModelData]) {
        self.budItemType = itemType
        self.healthManager = healthManager
        self.budItemData = budItemData
        
        self.budItem = initializeBudItem(itemType)
    }
    
    func initializeBudItem(_ itemType: BudItemType) -> WatchBudItem {
        switch itemType {
        case .Food:
            return WatchBudItem(type: BudItemType.Food, imageName: "fork.knife", colorScheme: Color.warmOrange, budItemData: fetchItemData("Food"))
        case .ActiveEnergy:
            return WatchBudItem(type: BudItemType.ActiveEnergy, imageName: "flame.fill", colorScheme: Color.brightRed, budItemData: fetchItemData("ActiveEnergy"))
        case .Water:
            return WatchBudItem(type: BudItemType.Water, imageName: "waterbottle.fill", colorScheme: Color.greenishCyan, budItemData: fetchItemData("Water"))
        }
    }
    
    func fetchItemData(_ type: String) -> WatchBudModelData {
        for budItem in budItemData {
            if budItem.itemType == type {
                return budItem
            }
        }
        
        return WatchBudModelData()
    }
    
    func calculateItemProgress() -> Double {
        switch budItem!.type {
        case .Food:
            return (Double(budItem!.budItemData.counter)/budItem!.budItemData.target) * 0.75
        case .ActiveEnergy:
            return (healthManager.calories/budItem!.budItemData.target) * 0.75
        case .Water:
            return (Double(healthManager.water)/budItem!.budItemData.target) * 0.75
        }
    }
    
    func calculateItemBudProgress() -> Double {
        switch budItem!.type {
        case .Food:
            return (Double(budItem!.budItemData.counter)/budItem!.budItemData.target) * 0.3
        case .ActiveEnergy:
            return (healthManager.calories/budItem!.budItemData.target) * 0.3
        case .Water:
            return (Double(healthManager.water)/budItem!.budItemData.target) * 0.3
        }
    }
    
    func fetchProgressAmount() -> Double {
        switch budItem!.type {
        case .Food:
            return Double(budItem!.budItemData.counter)
        case .ActiveEnergy:
            return healthManager.calories
        case .Water:
            return Double(healthManager.water)
        }
    }
    
    func fetchRemainingAmount() -> Double {
        switch budItem!.type {
        case .Food:
            return budItem!.budItemData.target - Double(budItem!.budItemData.counter)
        case .ActiveEnergy:
            return budItem!.budItemData.target - healthManager.calories
        case .Water:
            return budItem!.budItemData.target - Double(healthManager.water)
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
    
    func mealLogging() {
        if budItemType == .Food {
            budItem!.budItemData.counter += 1
        }
    }
}
