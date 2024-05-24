//  HealtDatamanager.swift
//
//  NC2
//
//  Created by Stevans Calvin Candra on 17/05/24.
//

import Foundation
import HealthKit

class HealthDataManager: ObservableObject {

    let healthStore = HKHealthStore()
    
    @Published var calories: Double = 0.0
    @Published var water: Int = 0
    @Published var sleep: String = ""
    @Published var hrv: Int = 0
    
    var startDate: Date
    var endDate: Date
    var rangeToday: NSPredicate
    
    let readType: Set = [
        HKQuantityType(.dietaryWater),
        HKQuantityType(.activeEnergyBurned),
        HKCategoryType(.sleepAnalysis),
        HKQuantityType(.heartRateVariabilitySDNN)
    ]
    
    init() {
        let calendar = Calendar(identifier: .gregorian)
        startDate = calendar.startOfDay(for: Date())
        endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        rangeToday = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        
        if HKHealthStore.isHealthDataAvailable() {
            Task {
                do {
                    try await healthStore.requestAuthorization(toShare: [HKQuantityType(.dietaryWater)], read: readType)
                } catch {
                    fatalError("An unexpected error accoured while initializing: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchCalories() async {
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: HKSamplePredicate.quantitySample(type: HKQuantityType(.activeEnergyBurned), predicate: rangeToday)
            , options: .cumulativeSum)
        
        do {
            let results = try await descriptor.result(for: healthStore)
            
            //delete on finish
//            print(startDate.formatted())
//            print(endDate.formatted())
//            print(results ?? "no records")
            
            DispatchQueue.main.async {
                if results != nil {
                    let burnedCalories = results?.sumQuantity()?.doubleValue(for: HKUnit.smallCalorie())
                    self.calories = (burnedCalories ?? 0) / 1000
                } else {
                    self.calories = 0.0
                }
            }
        } catch {
            print("Error on fetching data: \(error.localizedDescription)")
        }
    }
    
    func fetchWater() async {
        let descriptor = HKStatisticsQueryDescriptor(
            predicate: HKSamplePredicate.quantitySample(type: HKQuantityType(.dietaryWater), predicate: rangeToday)
            , options: .cumulativeSum)
        
        do {
            let results = try await descriptor.result(for: healthStore)
            
            //delete on finish
//            print(results ?? "no records")
            
            DispatchQueue.main.async {
                if results != nil {
                    let drink = Int(results?.sumQuantity()?.doubleValue(for: HKUnit.literUnit(with: .milli)) ?? 0)
                    self.water = drink
                }
            }
        } catch {
            print("Error on fetching data: \(error.localizedDescription)")
        }
    }
    
    func fetchSleep() async {
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.categorySample(type: HKCategoryType(.sleepAnalysis))],
            sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
            limit: 5)
        
        do {
            let results = try await descriptor.result(for: healthStore)
            
            //delete on finish
//            print(results)
            
            DispatchQueue.main.async {
                var hour = 0
                var minute = 0
                
                let calendar = Calendar(identifier: .gregorian)
                let currDate = calendar.startOfDay(for: Date())
                let startSleepCheck = calendar.date(byAdding: .hour, value: -6, to: currDate) //cek sejak jam 6 hari sebelumnya.
//                print(startSleepCheck?.formatted() ?? "No records")
                
                for result in results {
                    if result.value == 0 {
                        if result.startDate > startSleepCheck! {
                            let startSleep = result.startDate
                            let endSleep = result.endDate
                            let sleepTime = endSleep.timeIntervalSince(startSleep)
                            hour += Int(sleepTime / 3600)
                            minute += Int((Int(sleepTime) % 3600) / 60)
                        }
                    }
                }
                self.sleep = String(hour) + "hrs " + String(minute) + "min"
                
                //delete on finish
//                print(self.sleep)
//                print("Sleep Data: \(hour) hr \(minute) minutes")
            }
        } catch {
            print("Error on fetching data: \(error.localizedDescription)")
        }
    }
    
    func fetchHRV() async {
        let descriptor = HKSampleQueryDescriptor(
            predicates: [.quantitySample(type: HKQuantityType(.heartRateVariabilitySDNN))],
            sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
            limit: 1)
        
        do {
            let results = try await descriptor.result(for: healthStore)
            
            //delete on finish
//            print(results)
            
            DispatchQueue.main.async {
                if !results.isEmpty {
                    self.hrv = Int(results.first!.quantity.doubleValue(for: .secondUnit(with: .milli)))
                }
            }
        } catch {
            print("Error on fetching data: \(error.localizedDescription)")
        }
    }
}
