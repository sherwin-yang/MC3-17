//
//  DrillingPageViewController.swift
//  MC3-17
//
//  Created by Diana Ambarwati Febriani on 28/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import WatchConnectivity
import CoreML

class DrillingPageViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var borderImg: UIImageView!
    @IBOutlet weak var borderTxtLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    let accX = try? MLMultiArray(
        shape: [MlParameters.predictionWindowSize] as [NSNumber],
        dataType: MLMultiArrayDataType.double)
    
    let accY = try? MLMultiArray(
        shape: [MlParameters.predictionWindowSize] as [NSNumber],
        dataType: MLMultiArrayDataType.double)
    
    let accZ = try? MLMultiArray(
        shape: [MlParameters.predictionWindowSize] as [NSNumber],
        dataType: MLMultiArrayDataType.double)
    
    let rotX = try? MLMultiArray(
        shape: [MlParameters.predictionWindowSize] as [NSNumber],
        dataType: MLMultiArrayDataType.double)
    
    let rotY = try? MLMultiArray(
        shape: [MlParameters.predictionWindowSize] as [NSNumber],
        dataType: MLMultiArrayDataType.double)
    
    let rotZ = try? MLMultiArray(
        shape: [MlParameters.predictionWindowSize] as [NSNumber],
        dataType: MLMultiArrayDataType.double)
    
    var currentState = try? MLMultiArray(
        shape: [MlParameters.stateInLength as NSNumber],
        dataType: MLMultiArrayDataType.double)
    
    private let classifier = BadmintonActivityClassifier()
    private let modelName:String = "BadmintonActivityClassifier"
    var currentIndexInPredictionWindow = 0
    var wcSession : WCSession! = nil
    
    var results: Result!
    var newDrillDetails = [DrillDetail]()
    
    var checkWCTimer: Timer!
    var timer: Timer!
    var timeSecond = 0
    
    var permissionHelper = PermissionHelper()
    var isHealthStoreAuthorized = false
    var isRun = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activateWCSession()
        permissionHelper.delegate = self

        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
        self.checkWCTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(checkWatchConnectivity), userInfo: nil, repeats: true)
        
        checkHealthStoreAuth()
    }
    
    @objc func setTimer () {
        if isHealthStoreAuthorized && isRun {
            timeSecond += 1
            timerLabel.text = "\(countTimerHour()):\(countTimerMinute()):\(countTimerSecond())"
            print("run")
            
            descLabel.text = "You Are Now Drilling"
            borderImg.isHidden = true
            borderTxtLabel.isHidden = true
            cancelButton.isHidden = false
        }
    }
    
    func countTimerHour() -> String {
        if timeSecond/3600 < 10 {
            return "0\(timeSecond/3600)"
        }
        else {
            return "\(timeSecond/3600)"
        }
    }
    
    func countTimerMinute() -> String {
        if timeSecond%3600/60 < 10 {
            return "0\(timeSecond%3600/60)"
        }
        else {
            return "\(timeSecond%3600/60)"
        }
    }
    
    func countTimerSecond() -> String {
        if timeSecond%3600%60 < 10 {
            return "0\(timeSecond%3600%60)"
        }
        else {
            return "\(timeSecond%3600%60)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        results = Result(drillDetail: newDrillDetails)
        let drillResult = Drill(drill_name: SharedInfo.selectedDrill, video: nil, drill_details: newDrillDetails)
        DataModel.addNewData(drill: drillResult)
        if let identifer = segue.identifier {
            if identifer == SegueIdentifier.toResultsNoVideo {
                if let destination = segue.destination as? ResultNoVideoVC {
                    destination.results = results
                    destination.duration = timeSecond
                }
            }
        }
    }
    
}

//MARK: - PermissionHelperDelegate
extension DrillingPageViewController: PermissionHelperDelegate {
    func didSuccessHealthStoreAuth() {
        checkHealthStoreAuth()
    }
    
    func didFailHealthStoreAuth() {
        
    }
    
    func checkHealthStoreAuth(){
        switch permissionHelper.getHealthStoreAuthStatus() {
        case 0:
            print("notDetermined")
            permissionHelper.requestHealthStoreAuth()
            break
        case 1:
            print("sharingDenied")
            isHealthStoreAuthorized = false
            //do something here
            break
        case 2:
            print("sharingAuthorized")
            isHealthStoreAuthorized = true
            break
        default:
            permissionHelper.requestHealthStoreAuth()
        }
    }
}

//MARK: - WatchConnectivity
extension DrillingPageViewController: WCSessionDelegate {
    
    private func activateWCSession() {
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        activateWCSession()
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let instruction = message["instructionFromWatch"] as? String {
            print("INSTRUCTION1: \(instruction)")
            if instruction == "START" {
                self.isRun = true
            } else if instruction == "STOP" {
                self.isRun = false
                // Go to result page
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: SegueIdentifier.toResultsNoVideo, sender: self)
                }
            }
        }
        
        if let csv = message["motionFromWatch"] as? String {
            convertCsvStrToArray(csvStr: csv)
            //            print(csv)
            //            csvString = csvString.appending(csv)
        }
    }
    
    func sendMessage(strMsg: String, isPreditionData: Bool){
        var message = ["instructionFromIos":strMsg]
        if isPreditionData {
            message = ["preditionFromIos":strMsg]
        }
        
        wcSession.sendMessage(message, replyHandler: nil) { (error) in
            
            print(error.localizedDescription)
            
        }
    }
    
    @objc func checkWatchConnectivity(){
        if wcSession.isReachable == false{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: SegueIdentifier.toWatchConnectivity, sender: self)
            }
        }
    }
    
}

//MARK: - CoreML
extension DrillingPageViewController {
    
    func activityPrediction() -> String? {
        // Perform prediction
        let modelPrediction = try? classifier.prediction(
            Accelerometer_X: accX!,
            Accelerometer_Y: accY!,
            Accelerometer_Z: accZ!,
            Gyroscope_X: rotX!,
            Gyroscope_Y: rotY!,
            Gyroscope_Z: rotZ!,
            stateIn: currentState)
        
        // Update the state vector
        currentState = modelPrediction?.stateOut
        
        // print(modelPrediction?.labelProbability) //cek lob salah betul persentase.
        
        // Return the predicted activity
        return modelPrediction?.label
    }
    
    func convertCsvStrToArray(csvStr: String) {
        DispatchQueue.global().async {
            let lines = csvStr.split(separator: "\n")
            for line in lines {
                let columns = line.split(separator: ",", omittingEmptySubsequences: false)
                self.accX![self.currentIndexInPredictionWindow] = Double(columns[0])! as NSNumber
                self.accY![self.currentIndexInPredictionWindow] = Double(columns[1])! as NSNumber
                self.accZ![self.currentIndexInPredictionWindow] = Double(columns[2])! as NSNumber
                self.rotX![self.currentIndexInPredictionWindow] = Double(columns[3])! as NSNumber
                self.rotY![self.currentIndexInPredictionWindow] = Double(columns[4])! as NSNumber
                self.rotZ![self.currentIndexInPredictionWindow] = Double(columns[5])! as NSNumber
                
                // Update prediction array index
                self.currentIndexInPredictionWindow += 1
                
                // If data array is full - execute a prediction
                if (self.currentIndexInPredictionWindow == MlParameters.predictionWindowSize) {
                    // Move to main thread to update the UI
                    DispatchQueue.main.async {
                        if let predictionResult = self.activityPrediction() {
                            print("PREDICTION: \(predictionResult)")
                            if predictionResult == "lob_betul" {
                                self.newDrillDetails.append(DrillDetail(shotQuality: ShotQuality.goodMove, time: self.timeSecond)) // need time sended from watch
                            }
                            else if predictionResult == "lob_salah" {
                                self.newDrillDetails.append(DrillDetail(shotQuality: ShotQuality.badMove, time: self.timeSecond)) // need time sended from watch
                            }
                            
                            self.sendMessage(strMsg: predictionResult, isPreditionData: true)
                        }
                    }
                    // Start a new prediction window from scratch
                    self.currentIndexInPredictionWindow = 0
                }
            }
        }
    }
}
