//
//  ResultsVideo.swift
//  MC3-17
//
//  Created by Basit Tri Anggoro on 02/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

struct name {
    var attempts = 20
    var bad = 4
    var good = 16
    var totalScore: Int
    var color: UIColor
    
    mutating func countTotalScore(){
        totalScore = good/attempts*100
    }
    
    mutating func coloringTotalScore(){
        if totalScore >= 80{
            color = UIColor.green
        }else if totalScore >= 60{
            color = UIColor.yellow
        }else{
            color = UIColor.red
        }
    }
}
