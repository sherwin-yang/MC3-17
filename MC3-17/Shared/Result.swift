//
//  Result.swift
//  MC3-17
//
//  Created by Sherwin Yang on 04/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import Foundation

struct Result {
    var drillDetail = [DrillDetail]()
    
    func countTotalAttempts() -> Int {
        let attempts = drillDetail.count
        return attempts
    }
    
    func countGoodMoves() -> Int {
        var goodMoves = 0
        for i in 0..<drillDetail.count {
            if drillDetail[i].shotQuality == ShotQuality.goodMove {
                goodMoves += 1
            }
        }
        return goodMoves
    }
    
    func countBadMoves() -> Int {
        var badMoves = 0
        for i in 0..<drillDetail.count {
            if drillDetail[i].shotQuality == ShotQuality.badMove {
                badMoves += 0
            }
        }
        return badMoves
    }
    
    func countScoreResult() -> Int {
        return countGoodMoves()/countTotalAttempts()
    }
    
}
