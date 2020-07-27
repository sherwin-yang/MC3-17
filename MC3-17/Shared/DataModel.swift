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
    static var drills = [Drills]()
    static var drillDetails = [DrillDetails]()

    static func loadDrills() -> [Drills] {
        let requestDrill: NSFetchRequest<Drills> = Drills.fetchRequest()
        
        do {
            self.drills = try context.fetch(requestDrill)
        } catch {
            print("Error fetching data from context \(error)")
        }
        return drills
    }
    
    static func loadDrillDetails() -> [DrillDetails] {
        let requestDrillDetail: NSFetchRequest<DrillDetails> = DrillDetails.fetchRequest()
        
        do {
            self.drillDetails = try context.fetch(requestDrillDetail)
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
        let newDrill = Drills.init(context: context)
        let newDrillDetail = DrillDetails.init(context: context)
        
        newDrill.drill_number = Int16(drill.drill_number)
        newDrill.drill_name = drill.drill_name
        newDrill.video = drill.video
        drills.append(newDrill)
        self.save()
        
        for i in 0..<drill.drill_details.count {
            newDrillDetail.drillDetail_id = Int32(drill.drill_details[i].drillDetail_id)
            newDrillDetail.drill_number = Int16(drill.drill_number)
            newDrillDetail.shotQuality = drill.drill_details[i].shotQuality
            newDrillDetail.time = Int16(drill.drill_details[i].time)
            newDrillDetail.header = newDrill
            drillDetails.append(newDrillDetail)
            self.save()
        }
    }

}
