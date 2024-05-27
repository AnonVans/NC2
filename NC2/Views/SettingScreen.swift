//
//  HomeScreen.swift
//  NC2
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import SwiftUI
import SwiftData

struct SettingScreen: View {
    @Environment(\.modelContext) var itemModel
    @Query var items: [BudDataModel]
    
    @State var mealNum: Int = 0
    @State var energyNum: Int = 0
    @State var waterNum: Int = 0
    
    @State var mealTarget: String = ""
    @State var energyTarget: String = ""
    @State var waterTarget: String = ""
    
    @ObservedObject var watchConnetor = WatchAppConnecter()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .onAppear {
                    initData()
                }
                
                Form {
                    VStack {
                        HStack {
                            Text("Meal Number Target")
                                .font(.system(size: 17.5))
                                .frame(width: 110, height: 50, alignment: .leading)
                                .padding(.trailing, 30)
                            
                            TextField("\(mealNum) meals", text: $mealTarget)
                                .font(.title3)
                                .onSubmit {
                                    print(mealTarget)
                                    saveData("Food", Double(mealTarget) ?? 3.0)
                                    mealNum = Int(mealTarget) ?? 3
                                }
                        }
                        .frame(height: 50)
                        .padding(.vertical, 5)
                        
                        HStack {
                            Text("Active Energy Burn Target")
                                .font(.system(size: 17.5))
                                .frame(width: 110, height: 50, alignment: .leading)
                                .padding(.trailing, 30)
                            
                            TextField("\(energyNum) kcal", text: $energyTarget)
                                .font(.title3)
                                .onSubmit {
                                    print(energyTarget)
                                    saveData("ActiveEnergy", Double(energyTarget) ?? 250.0)
                                    mealNum = Int(energyTarget) ?? 250
                                }
                        }
                        .frame(height: 50)
                        .padding(.vertical, 5)
                        
                        HStack {
                            Text("Water Intake Target")
                                .font(.system(size: 17.5))
                                .frame(width: 110, height: 50, alignment: .leading)
                                .padding(.trailing, 30)
                            
                            TextField("\(waterNum) ml", text: $waterTarget)
                                .font(.title3)
                                .onSubmit {
                                    print(waterTarget)
                                    saveData("Water", Double(waterTarget) ?? 2000.0)
                                    mealNum = Int(waterTarget) ?? 2000
                                }
                        }
                        .frame(height: 50)
                        .padding(.vertical, 5)
                    }
                }
                .formStyle(GroupedFormStyle())
                .frame(width: 400, height: 300)
                
            }
            .padding()
            
            Button("Save Data") {
                sendDataToWatch()
            }
            .buttonStyle(BorderedProminentButtonStyle())
        }
    }
    
    func initData() {
        if items.isEmpty {
            let foodItem = BudDataModel(itemType: "Food", counter: 0, target: 3, timeStamp: Date())
            let energyItem = BudDataModel(itemType: "ActiveEnergy", counter: 0, target: 250, timeStamp: Date())
            let waterItem = BudDataModel(itemType: "Water", counter: 0, target: 2000, timeStamp: Date())
            
            itemModel.insert(foodItem)
            itemModel.insert(energyItem)
            itemModel.insert(waterItem)
        }
        
        mealNum = Int(fetchDataItem("Food").target)
        energyNum = Int(fetchDataItem("ActiveEnergy").target)
        waterNum = Int(fetchDataItem("Water").target)

    }
    
    func fetchDataItem(_ type: String) -> BudDataModel {
        for item in items {
            if item.itemType == type {
                return item
            }
        }
        
        return BudDataModel()
    }
    
    func saveData(_ type: String, _ newTarget: Double) {
        for item in items {
            if item.itemType == type {
                item.target = newTarget
                
                try? itemModel.save()
            }
        }
    }
    
    func sendDataToWatch() {
        let data = [
            Double(mealTarget) ?? 3.0,
            Double(energyTarget) ?? 250.0,
            Double(waterTarget) ?? 2000.0
        ]
        
        watchConnetor.sendData(data)
    }
}

#Preview {
    SettingScreen()
}
