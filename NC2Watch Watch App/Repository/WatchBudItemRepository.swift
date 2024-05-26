//
//  WatchBudItemRepository.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 27/05/24.
//

import Foundation
import SwiftData

class WatchBudItemRepository {
    var modelContext: ModelContext
    var budItems: [WatchBudModelData]
    
    init(modelContext: ModelContext, budItems: [WatchBudModelData]) {
        self.modelContext = modelContext
        self.budItems = budItems
        
        initializeRepo()
    }
    
    func initializeRepo() {
        if budItems.isEmpty {
            let foodItem = WatchBudModelData(itemType: "Food", counter: 0, target: 3, timeStamp: Date())
            let energyItem = WatchBudModelData(itemType: "ActiveEnergy", counter: 0, target: 250, timeStamp: Date())
            let waterItem = WatchBudModelData(itemType: "Water", counter: 0, target: 2000, timeStamp: Date())
            
            modelContext.insert(foodItem)
            modelContext.insert(energyItem)
            modelContext.insert(waterItem)
        }
    }
    
//    func getFoodItem() -> WatchBudItem {
//        for budItem in budItems {
//            if budItem.itemType == BudItemType.Food {
//                return ()
//            }
//        }
//    }
}
