//
//  BudDataModel.swift
//  NC2
//
//  Created by Stevans Calvin Candra on 27/05/24.
//

import Foundation
import SwiftData

@Model
class BudDataModel: Identifiable {
    var id = UUID()
    var itemType: String = ""
    var counter: Int
    var target: Double
    var timeStamp: Date
    
    init(id: UUID = UUID(), itemType: String = "", counter: Int = 0, target: Double = 0.0, timeStamp: Date = Date()) {
        self.itemType = itemType
        self.counter = counter
        self.target = target
        self.timeStamp = timeStamp
    }
}
