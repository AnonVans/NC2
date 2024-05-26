//
//  WatchProgressIndicator.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import Foundation
import SwiftUI

enum BudTypes: String {
    case Sprout = "Sprout"
    case Sapling = "Sapling"
    case YoungTree = "YoungTree"
    case AdultTree = "AdultTree"
    case PeakSeason = "FullBloom"
}

enum BudState: String {
    case Normal = "Normal"
    case Stressed = "Stressed"
    case SleepDeprived = "SleepDeprived"
}

enum BudItemType {
    case Food
    case ActiveEnergy
    case Water
}

class WatchBuds {
    var type: BudTypes
    var state: BudState
    
    init(type: BudTypes, state: BudState) {
        self.type = type
        self.state = state
    }
}

class WatchBudItem {
    var type: BudItemType
    var imageName: String = ""
    var colorScheme: Color
    var counter: Int
    var target: Double
    
    init(type: BudItemType, imageName: String, colorScheme: Color, counter: Int, target: Double) {
        self.type = type
        self.imageName = imageName
        self.colorScheme = colorScheme
        self.counter = counter
        self.target = target
    }
}
