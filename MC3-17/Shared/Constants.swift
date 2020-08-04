//
//  Constants.swift
//  MC3-17
//
//  Created by Sherwin Yang on 22/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import Foundation

struct SharedInfo {
    static var selectedDrill: String?
}

struct ShotQuality {
    static let goodMove = "good"
    static let badMove = "bad"
}

struct SegueIdentifier {
    static let toShotsPage = "toShotsPage"
    static let toDrillPage = "toDrillPage"
    static let toPopUpScreen = "toPopUpScreen"
    static let toCameraScreen = "toCameraScreen"
    static let toDrillingPage = "toDrillingPage"
    static let toInfoPage = "toInfoPage"
    static let cameraToInfoPage = "cameraToInfoPage"
    static let toVideoPage = "toVideoPage"
    static let toCategoryPage = "toCategoryPage"
}

struct DrillName {
    static let lob = "Lob"
    static let drive = "Drive"
    static let smash = "Smash"
    static let dropshot = "Dropshot"
    static let netshot = "Netshot"
}

struct DrillDescription {
    static let lob = "The most important thing you need to know about this shots is you have to hit shuttlecock hardly and make sure the shuttlecock reaches the back of the court."
    static let smash = "In smash, the movement is similar to lob shots but it requires more power and speed, and the shot angle must as small as possible so the shuttlecock hits court faster."
}

struct AppleWatchConnectivity {
    static let connected = "connected"
    static let disonnected = "disconnected"
    static let connectedLabel = "Connected to Apple Watch"
    static let disconnectedLabel = "Disconnected From Apple Watch"
}

struct MlParameters {
    static let predictionWindowSize = 60
    static let sensorsUpdateFrequency = 1.0 / 75.0
    static let stateInLength = 400
}
