//
//  WatchProgressIndicator.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 21/05/24.
//

import Foundation
import SwiftUI

enum BudTypes {
    case Sprout
    case Sapling
    case YoungTree
    case AdultTree
    case PeakSeason
}

enum BudItemType {
    case Food
    case ActiveEnergy
    case Water
}

class WatchBuds {
    var type: BudTypes
    var imageName: String = ""
    
    init(type: BudTypes, imageName: String) {
        self.type = type
        self.imageName = imageName
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
