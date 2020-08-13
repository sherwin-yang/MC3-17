//
//  DataModel.swift
//  MC3-17
//
//  Created by Sherwin Yang on 22/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import CoreData

struct DataModel {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static func loadDrills() -> [Drills] {
        var drills = [Drills]()
        let requestDrill: NSFetchRequest<Drills> = Drills.fetchRequest()
        
        do {
            drills = try context.fetch(requestDrill)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return drills
    }
    
    static func loadDrillDetails() -> [DrillDetails] {
        var drillDetails = [DrillDetails]()
        let requestDrillDetail: NSFetchRequest<DrillDetails> = DrillDetails.fetchRequest()
        
        do {
            drillDetails = try context.fetch(requestDrillDetail)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return drillDetails
    }

    static func save() {
        do {
            try context.save()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    static func addNewData(drill: Drill) {
        if drill.drill_details.count != 0 {
            var drillsData = loadDrills()
            let newDrill = Drills.init(context: context)
            
            newDrill.drill_number = Int16(drillsData.count+1)
            newDrill.drill_name = drill.drill_name
            newDrill.video = drill.video
            drillsData.append(newDrill)
            self.save()
            
            for i in 0..<drill.drill_details.count {
                var drillDetailsData = loadDrillDetails()
                let newDrillDetail = DrillDetails.init(context: context)
                
                newDrillDetail.drillDetail_id = Int32(drillDetailsData.count+i+1)
                newDrillDetail.drill_number = Int16(newDrill.drill_number)
                newDrillDetail.shotQuality = drill.drill_details[i].shotQuality
                newDrillDetail.time = Int16(drill.drill_details[i].time)
                newDrillDetail.header = newDrill
                drillDetailsData.append(newDrillDetail)
                self.save()
            }
        }
    }
}
