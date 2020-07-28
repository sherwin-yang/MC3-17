//
//  MoveCategory.swift
//  MC3-17
//
//  Created by Sherwin Yang on 28/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import Foundation

struct MoveCategory {
    var shotQuality: String
    var time: Int
    
    static func passGoodMoves(_ moves: [MoveCategory]) -> [MoveCategory] {
        var goodMoves = [MoveCategory]()
        for i in 0..<moves.count {
            if moves[i].shotQuality == ShotQuality.goodMove {
                goodMoves.append(moves[i])
            }
        }
        return goodMoves
    }
    
    static func passBadMoves(_ moves: [MoveCategory]) -> [MoveCategory] {
        var badMoves = [MoveCategory]()
        for i in 0..<moves.count {
            if moves[i].shotQuality == ShotQuality.badMove {
                badMoves.append(moves[i])
            }
        }
        return badMoves
    }
}
