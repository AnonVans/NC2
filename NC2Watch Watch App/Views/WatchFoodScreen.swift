//
//  WatchFoodScreen.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import SwiftUI

struct WatchFoodScreen: View {
    @EnvironmentObject var healthManager: HealthDataManager
    
    var homeViewModel: WatchHomeViewModel
    var itemViewModel: WatchBudItemViewModel
    
    var body: some View {
        ZStack {
            WatchBackground(color: itemViewModel.budItem!.colorScheme)
            
            VStack {
                HStack {
                    WatchBudProgressRing(homeViewModel: homeViewModel, budItemType: BudItemType.Food, imageSize: 15.0, frameHeightInner: 21.5, frameHeightOutter: 28.5, lineWidth: 2.5)
                        .padding(.horizontal, 6)
                        .padding(.vertical, -15)
                    
                    Spacer()
                }
                
                VStack {
                    WatchProgressRing(itemViewModel: itemViewModel)
                    
                    HStack {
                        HStack {
                            Text(String(Int(itemViewModel.fetchProgressAmount())))
                                .font(.caption)
                                .bold()
                                .foregroundStyle(itemViewModel.budItem!.colorScheme)
                            Text("/ 3 meals")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: WatchMealsLogging()) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(itemViewModel.budItem!.colorScheme)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 12)
                }
            }
            .frame(width: 165, height: 165)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                itemViewModel.changeViewDisplay()
            }
        }
    }
}

#Preview {
    WatchFoodScreen(homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager()), itemViewModel: WatchBudItemViewModel(itemType: BudItemType.Food, healthManager: HealthDataManager()))
}
