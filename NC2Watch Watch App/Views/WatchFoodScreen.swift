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
//    var itemViewModel: WatchBudItemViewModel
    
    var body: some View {
        ZStack {
            WatchBackground(color: homeViewModel.foodItemViewModel.budItem!.colorScheme)
            
            VStack {
                HStack {
                    ZStack {
                        WatchBudProgressRing(homeViewModel: homeViewModel, frameHeightInner: 21.5, lineWidth: 2.5)
                        
                        WatchOuterBudRing(homeViewModel: homeViewModel, budItemType: BudItemType.Food, frameHeightOutter: 28.5, lineWidth: 2.5)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, -15)
                    
                    Spacer()
                }
                
                VStack {
                    WatchProgressRing(itemViewModel: homeViewModel.foodItemViewModel, progressFrameSize: 115, imageFrameSize: 75, lineWidth: 7.5, inHomeScreen: false)
                    
                    HStack {
                        HStack {
                            Text(String(Int(homeViewModel.foodItemViewModel.fetchProgressAmount())))
                                .font(.caption)
                                .bold()
                                .foregroundStyle(homeViewModel.foodItemViewModel.budItem!.colorScheme)
                            Text("/ " + String(Int(homeViewModel.foodItemViewModel.budItem!.budItemData.target)) + " meals")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: WatchMealsLogging(foodItemModel: homeViewModel.foodItemViewModel)) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(homeViewModel.foodItemViewModel.budItem!.colorScheme)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 12)
                }
            }
            .frame(width: 165, height: 165)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                homeViewModel.foodItemViewModel.changeViewDisplay()
            }
        }
    }
}

#Preview {
    WatchFoodScreen(homeViewModel: WatchHomeViewModel(healthManager: HealthDataManager(), budItems: []))
}
