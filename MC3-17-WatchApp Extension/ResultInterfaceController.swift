//
//  ResultInterfaceController.swift
//  MC3-17-WatchApp Extension
//
//  Created by Sherwin Yang on 30/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import WatchKit
import Foundation

class ResultInterfaceController: WKInterfaceController {

    @IBOutlet var totalTimeLabel: WKInterfaceLabel!
    @IBOutlet var totalAttemptsLabel: WKInterfaceLabel!
    @IBOutlet var totalGoodMoveLabel: WKInterfaceLabel!
    @IBOutlet var totalBadMoveLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let result = context as? Result {
            totalTimeLabel.setText("\(countTimerHour(result.timeSecond)):\(countTimerMinute(result.timeSecond)):\(countTimerSecond(result.timeSecond))")
            totalAttemptsLabel.setText("\(result.goodMoves + result.badMoves)")
            totalGoodMoveLabel.setText("\(result.goodMoves)")
            totalBadMoveLabel.setText("\(result.badMoves)")
        }
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func countTimerHour(_ time: Int) -> String {
        if time/3600 < 10 {
            return "0\(time/3600)"
        }
        else {
            return "\(time/3600)"
        }
    }
    
    func countTimerMinute(_ time: Int) -> String {
        if time%3600/60 < 10 {
            return "0\(time%3600/60)"
        }
        else {
            return "\(time%3600/60)"
        }
    }
    
    func countTimerSecond(_ time: Int) -> String {
        if time%3600%60 < 10 {
            return "0\(time%3600%60)"
        }
        else {
            return "\(time%3600%60)"
        }
    }
    
}
