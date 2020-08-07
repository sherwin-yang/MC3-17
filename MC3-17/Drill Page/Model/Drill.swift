//
//  Drill.swift
//  MC3-17
//
//  Created by Sherwin Yang on 20/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import Foundation

struct Drill {
    var drill_name: String!
    var video: String?
    var drill_details = [DrillDetail]()
    
    static let drillsCoreData = DataModel.loadDrills()
    static let drillDetailsCoreData = DataModel.loadDrillDetails()
    
    static func countTotalAttempts(_ drillName: String) -> Int {
        var totalAttempts = 0
        
        for drill in drillsCoreData {
            if drill.drill_name == drillName {
                for drillDetail in drillDetailsCoreData {
                    if drill.drill_number == drillDetail.drill_number {
                        totalAttempts += 1;
                    }
                }
            }
        }
        
        return totalAttempts
    }
    
    static func countGoodMoves(_ drillName: String) -> Int {
        var totalGoodMoves = 0
        
        for drill in drillsCoreData {
            if drill.drill_name == drillName {
                for drillDetail in drillDetailsCoreData {
                    if drill.drill_number == drillDetail.drill_number {
                        if drillDetail.shotQuality == ShotQuality.goodMove {
                            totalGoodMoves += 1;
                        }
                    }
                }
            }
        }
        
        return totalGoodMoves
    }
    
    static func countBadMoves(_ drillName: String) -> Int {
        var totalBadMoves = 0
        
        for drill in drillsCoreData {
            if drill.drill_name == drillName {
                for drillDetail in drillDetailsCoreData {
                    if drill.drill_number == drillDetail.drill_number {
                        if drillDetail.shotQuality == ShotQuality.badMove {
                            totalBadMoves += 1
                        }
                    }
                }
            }
        }
        
        return totalBadMoves
    }
    
    static func findHighestScore(_ drillName: String) -> Int {
        var highestScore: Double = 0
        
        for drill in drillsCoreData {
            if drill.drill_name == drillName {
                var attempts: Double = 0
                var goodMoves: Double = 0
                for drillDetail in drillDetailsCoreData {
                    if drill.drill_number == drillDetail.drill_number {
                        attempts += 1
                        if drillDetail.shotQuality == ShotQuality.goodMove {
                            goodMoves += 1
                        }
                    }
                }
                highestScore = calculateHighestScore(currentHighestScore: highestScore, newTotalAttempts: attempts, newTotalGoodMoves: goodMoves)
            }
        }
        
        return Int(highestScore)
    }
    
    static func calculateHighestScore(currentHighestScore: Double, newTotalAttempts: Double, newTotalGoodMoves: Double) -> Double {
        if newTotalAttempts != 0 {
            let newHighestScore = newTotalGoodMoves/newTotalAttempts*100
            
            if newHighestScore > currentHighestScore {
                return newHighestScore
            }
        }
        
        return currentHighestScore
    }
    
}

struct DrillDetail {
    var shotQuality: String
    var time: Int
}
