//
//  InterfaceController.swift
//  MC3-17-WatchApp Extension
//
//  Created by Sherwin Yang on 30/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var timerLabel: WKInterfaceLabel!
    @IBOutlet var goodMoveLabel: WKInterfaceLabel!
    @IBOutlet var badMoveLabel: WKInterfaceLabel!
    @IBOutlet var startButton: WKInterfaceButton!
    @IBOutlet var stopButton: WKInterfaceButton!
    
    var timer: Timer!
    var result = Result(goodMoves: 0, badMoves: 0, timeSecond: 0)
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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
    
    @IBAction func startButtonTapped() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
        startButton.setHidden(true)
        stopButton.setHidden(false)
    }
    
    @IBAction func stopButtonTapped() {
        timer.invalidate()
        timer = nil
        timerLabel.setText("00:00:00")
        goodMoveLabel.setText("0")
        badMoveLabel.setText("0")
        startButton.setHidden(false)
        stopButton.setHidden(true)
        pushController(withName: "showResult", context: result)
        result = Result(goodMoves: 0, badMoves: 0, timeSecond: 0)
    }
    
    @objc func setTimer() {
        result.timeSecond += 1
        timerLabel.setText("\(countTimerHour()):\(countTimerMinute()):\(countTimerSecond())")
    }
    
    func countTimerHour() -> String {
        if result.timeSecond/3600 < 10 {
            return "0\(result.timeSecond/3600)"
        }
        else {
            return "\(result.timeSecond/3600)"
        }
    }
    
    func countTimerMinute() -> String {
        if result.timeSecond%3600/60 < 10 {
            return "0\(result.timeSecond%3600/60)"
        }
        else {
            return "\(result.timeSecond%3600/60)"
        }
    }
    
    func countTimerSecond() -> String {
        if result.timeSecond%3600%60 < 10 {
            return "0\(result.timeSecond%3600%60)"
        }
        else {
            return "\(result.timeSecond%3600%60)"
        }
    }
}
