//
//  WatchMealsLogging.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 22/05/24.
//

import SwiftUI
import SwiftData

struct WatchMealsLogging: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var itemModel
    
    @Query var budItems: [WatchBudModelData]
    
    var foodItemModel: WatchBudItemViewModel
    
    var body: some View {
        ZStack {
            WatchBackground(color: Color.orange)
            
            VStack {
                Text("Do you want to log your meal?")
                    .font(.caption2)
                    .bold()
                    .foregroundStyle(Color.orange)
                    .padding(15)
                
                Button {
                    for budItem in budItems {
                        if budItem.itemType == "Food" {
                            budItem.counter += 1
                            budItem.timeStamp = Date()
                            try? itemModel.save()
                            
                            print("Success adding meal")
                        }
                    }
                    
                    foodItemModel.changeViewDisplay()
                    
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Log A Meal")
                    }
                    .font(.headline)
                    .bold()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(Color.orange)
                .scaleEffect(0.8)
                .frame(width: 140, height: 40)
                .padding(10)
            }
        }
    }
}

#Preview {
    WatchMealsLogging(foodItemModel: WatchBudItemViewModel(itemType: BudItemType.Food, healthManager: HealthDataManager(), budItemData: []))
}
