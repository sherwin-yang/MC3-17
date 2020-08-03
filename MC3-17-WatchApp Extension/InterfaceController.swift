//
//  InterfaceController.swift
//  MC3-17-WatchApp Extension
//
//  Created by Sherwin Yang on 30/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import CoreMotion
import HealthKit
import CoreML

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var timerLabel: WKInterfaceLabel!
    @IBOutlet var goodMoveLabel: WKInterfaceLabel!
    @IBOutlet var badMoveLabel: WKInterfaceLabel!
    @IBOutlet var startButton: WKInterfaceButton!
    @IBOutlet var stopButton: WKInterfaceButton!
    @IBOutlet weak var heartRateLabel: WKInterfaceLabel!
    
    var timer: Timer!
    var result = Result(goodMoves: 0, badMoves: 0, timeSecond: 0)
    
    var wcSession : WCSession!
    var motion = CMMotionManager()
    var dataMotionArray:[Dictionary<String, AnyObject>] =  Array()
    
    //workout
    let healthStore = HKHealthStore()
    var wkSession: HKWorkoutSession?
    var currentQuery: HKQuery?
    let sensorsUpdateFrequency = 1.0 / 75.0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
        
        //Check HealthStore
        guard HKHealthStore.isHealthDataAvailable() == true else {
            print("Health Data Not Avaliable")
            return
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func startButtonTapped() {
        startRecording()
    }
    
    @IBAction func stopButtonTapped() {
        stopRecording()
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
    
    func startRecording(){
        sendMessage(strMsg: "START", isMotion: false)
        startWorkout()
        startDeviceMotion()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
        startButton.setHidden(true)
        stopButton.setHidden(false)
    }
    
    func stopRecording(){
        sendMessage(strMsg: "STOP", isMotion: false)
        stopDeviceMotion()
        wkSession?.stopActivity(with: Date())
        heartRateLabel.setText("0")
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
}

//MARK: - CoreMotion
extension InterfaceController {
    
    func startDeviceMotion(){
        var csvString = ""
        var dataMotionCounter = 0
        motion.deviceMotionUpdateInterval  = sensorsUpdateFrequency
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) {
            (data, error) in
//            print(data as Any)
            if let trueData =  data {
                
                csvString = "\(trueData.userAcceleration.x),\(trueData.userAcceleration.y),\(trueData.userAcceleration.z),\(trueData.rotationRate.x),\(trueData.rotationRate.y),\(trueData.rotationRate.z)\n"
                dataMotionCounter += 1
                
                if dataMotionCounter == 10 {
                    self.sendMessage(strMsg: csvString, isMotion: true)
                    csvString = ""
                    dataMotionCounter = 0
                }
            }
        }
        return
    }
    
    func stopDeviceMotion() {
        motion.stopDeviceMotionUpdates()
    }
}

//    MARK: - WCSession
extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let prediction = message["preditionFromIos"] as? String {
            print(prediction)
            if prediction == "lob_betul" {
                result.goodMoves += 1
                goodMoveLabel.setText(String(result.goodMoves))
            } else if prediction == "lob_salah" {
                result.badMoves += 1
                badMoveLabel.setText(String(result.badMoves))
            }
        }
        
        if let instruction = message["instructionFromIos"] as? String {
            print(instruction)
            if instruction == "STOP" {
                stopRecording()
            }
        }
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
        // Code.
        
    }
    
    func sendMessage(strMsg: String, isMotion: Bool){
        var message = ["instructionFromWatch":strMsg]
        if isMotion {
            message = ["motionFromWatch":strMsg]
        }
        
        wcSession.sendMessage(message, replyHandler: nil) { (error) in
            
            print(error.localizedDescription)
            
        }
        
        print("sendMessage")
    }
    
//    func sendMessageWithReply(strMsg: String){
//        let message = ["instructionFromWatch":strMsg]
//
//        if isReachable() {
//            wcSession.sendMessage(message, replyHandler: { (response) in
//                print("Reply: \(response)")
//            }, errorHandler: { (error) in
//                print("Error sending message: %@", error)
//            })
//        } else {
//            print("iPhone is not reachable!!")
//        }
//    }
    
    private func isReachable() -> Bool {
        return wcSession.isReachable
    }
}

//MARK: - WorkOut
extension InterfaceController: HKWorkoutSessionDelegate{
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        print("State: \(toState.rawValue)")
        switch toState {
        case .running:
            print(date)
            if let query = heartRateQuery(date){
                self.currentQuery = query
                healthStore.execute(query)
            }
        //Execute Query
        case .stopped:
            //Stop Query
            print("STOP: \(date)")
            healthStore.stop(self.currentQuery!)
            wkSession?.end()
            wkSession = nil
        default:
            print("Unexpected state: \(toState.rawValue)")
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        //Do Nothing
    }
    
    func startWorkout(){
        // If a workout has already been started, do nothing.
        if (wkSession != nil) {
            return
        }
        // Configure the workout session.
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .badminton
        workoutConfiguration.locationType = .indoor
        
        do {
            wkSession = try HKWorkoutSession(healthStore: healthStore, configuration: workoutConfiguration)
            wkSession?.delegate = self
        } catch {
            fatalError("Unable to create workout session")
        }
        
        wkSession?.startActivity(with: Date())
        print("Start Workout Session")
    }
    
    func heartRateQuery(_ startDate: Date) -> HKQuery? {
        let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)
        let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: nil, options: .strictEndDate)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates:[datePredicate])
        
        let heartRateQuery = HKAnchoredObjectQuery(type: quantityType!, predicate: predicate, anchor: nil, limit: Int(HKObjectQueryNoLimit)) { (query, sampleObjects, deletedObjects, newAnchor, error) -> Void in
            //Do nothing
        }
        
        heartRateQuery.updateHandler = {(query, samples, deleteObjects, newAnchor, error) -> Void in
            guard let samples = samples as? [HKQuantitySample] else {return}
            DispatchQueue.main.async {
                guard let sample = samples.first else { return }
                let value = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                print("This line is executed!")
                self.heartRateLabel.setText(String(UInt16(value))) //Update label
            }
            
        }
        
        return heartRateQuery
    }
    
}
