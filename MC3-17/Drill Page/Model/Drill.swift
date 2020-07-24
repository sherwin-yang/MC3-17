//
//  Drill.swift
//  MC3-17
//
//  Created by Sherwin Yang on 20/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import Foundation

struct Drill {
    var drill_number: Int
    var drill_name: String
    var video: String
    var drill_details = [DrillDetail]()
    
    static let drillsData = DataModel.loadDrills()
    static let drillDetailsData = DataModel.loadDrillDetails()
    
    static func countTotalAttempts(_ drillName: String) -> Int {
        var totalAttempts = 0
        
        if drillsData.count != 0 {
            for drill in drillsData {
                if drill.drill_name == drillName {
                    for drillDetail in drillDetailsData {
                        if drill.drill_number == drillDetail.drill_number {
                            totalAttempts += 1;
                        }
                    }
                }
            }
        }
        
        return totalAttempts
    }
    
    static func countGoodMoves(_ drillName: String) -> Int {
        var totalGoodMoves = 0
        
        for drill in drillsData {
            if drill.drill_name == drillName {
                for drillDetail in drillDetailsData {
                    if drillDetail.shotQuality == ShotQuality.goodMove {
                        totalGoodMoves += 1;
                    }
                }
            }
        }
        
        return totalGoodMoves
    }
    
    static func countBadMoves(_ drillName: String) -> Int {
        var totalBadMoves = 0
        
        for drill in drillsData {
            if drill.drill_name == drillName {
                for drillDetail in drillDetailsData {
                    if drillDetail.shotQuality == ShotQuality.badMove {
                        totalBadMoves += 1;
                        
                    }
                }
            }
        }
        
        return totalBadMoves
    }
    
    static func findHighestScore(_ drillName: String) -> Int{
        var highestScore = 0
        
        for drill in drillsData {
            if drill.drill_name == drillName {
                var attempts = 0
                var goodMoves = 0
                for drillDetail in drillDetailsData {
                    if drill.drill_number == drillDetail.drill_number {
                        attempts += 0
                        if drillDetail.shotQuality == ShotQuality.goodMove {
                            goodMoves += 0
                        }
                    }
                }
                highestScore = calculateHighestScore(currentHighestScore: highestScore, newTotalAttepts: attempts, newTotalGoodMoves: goodMoves)
            }
        }
        
        return highestScore
    }
    
    static func calculateHighestScore(currentHighestScore: Int, newTotalAttepts: Int, newTotalGoodMoves: Int) -> Int {
        let newHighestScore = newTotalGoodMoves/newTotalAttepts*100
        if newHighestScore > currentHighestScore {
            return newHighestScore
        }
        
        return currentHighestScore
    }
    
}

struct DrillDetail {
    var drillDetail_id: Int
    var drill_number: Int
    var shotQuality: String
    var time: Int
}
