//
//  WatchBudModelData.swift
//  NC2Watch Watch App
//
//  Created by Stevans Calvin Candra on 27/05/24.
//

import Foundation
import SwiftData

@Model
class WatchBudModelData: Identifiable {
    var id = UUID()
    var itemType: String = ""
    var counter: Int
    var target: Int
    var timeStamp: Date
    
    init(id: UUID = UUID(), itemType: String, counter: Int, target: Int, timeStamp: Date) {
        self.itemType = itemType
        self.counter = counter
        self.target = target
        self.timeStamp = timeStamp
    }
}
