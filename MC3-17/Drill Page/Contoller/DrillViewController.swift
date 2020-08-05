//
//  DrillViewController.swift
//  MC3-17
//
//  Created by Sherwin Yang on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import WatchConnectivity

class DrillViewController: UIViewController {

    @IBOutlet var drillCardView: UIView!
    @IBOutlet var drillNameLabel: UILabel!
    @IBOutlet var videoThumbnail: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var totalAttemptsLabel: UILabel!
    @IBOutlet var badMovesLabel: UILabel!
    @IBOutlet var goodMovesLabel: UILabel!
    @IBOutlet var highestScoreLabel: UILabel!
    @IBOutlet var appleWatchConnectivityMark: UIView!
    @IBOutlet var appleWatchConnectivityLabel: UILabel!
    
    var videoName: String?
    
    var URIPATH: URL!
    var thumbnail: UIImage!
    let file = Bundle.main.url(forResource: "Lob Video", withExtension: "mp4")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drillCardView.addCardShadow()
        self.setAllLabels()
        generateThumbnail()
        self.activateWCSession()
        print("VC : " + "\(navigationController?.viewControllers.count)")
    }
    
    @IBAction func playVideoButton(_ sender: Any) {
        if let path = Bundle.main.path(forResource: videoName, ofType: "mp4") {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            present(videoPlayer, animated: true) {
                video.play()
            }
        }
    }
    
    func setAllLabels() {
        if SharedInfo.selectedDrill != nil {
            self.drillNameLabel.text = SharedInfo.selectedDrill
            self.setDescriptionLabel()
            self.totalAttemptsLabel.text = String(Drill.countTotalAttempts(SharedInfo.selectedDrill!))
            if Drill.countTotalAttempts(SharedInfo.selectedDrill!) != 0 {
                self.badMovesLabel.text = String(Drill.countBadMoves(SharedInfo.selectedDrill!))
                self.goodMovesLabel.text = String(Drill.countGoodMoves(SharedInfo.selectedDrill!))
                self.highestScoreLabel.text = String(Drill.findHighestScore(SharedInfo.selectedDrill!))
            }
        }
    }
    
    func setDescriptionLabel() {
        if SharedInfo.selectedDrill == DrillName.lob {
            self.descriptionLabel.text = DrillDescription.lob
        }
        else if SharedInfo.selectedDrill == DrillName.smash {
            self.descriptionLabel.text = DrillDescription.smash
        }
    }
    
    func generateThumbnail() {
            do{
                if let cekURL = file {
                    let asset = AVURLAsset(url: cekURL)
                    let imageGenerator = AVAssetImageGenerator(asset: asset)
                    imageGenerator.appliesPreferredTrackTransform = true
                    let cgImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 1), actualTime: nil)
                    thumbnail = UIImage(cgImage: cgImage)
                    videoThumbnail.image = thumbnail
                }
                else{
                    return print("error generating thumbnail")
                }
            }catch let error{
                print(error.localizedDescription)
            }
        }
    
    func setVideoName() -> String {
        if SharedInfo.selectedDrill == DrillName.lob {
            self.videoName = "Lob Video"
        }
        
        return videoName!
    }
}

extension DrillViewController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.appleWatchConnectivityMark.appleWatchMarkColor(connectivity: AppleWatchConnectivity.connected)
            self.appleWatchConnectivityLabel.text = AppleWatchConnectivity.connectedLabel
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        DispatchQueue.main.async {
            self.appleWatchConnectivityMark.appleWatchMarkColor(connectivity: AppleWatchConnectivity.disonnected)
            self.appleWatchConnectivityLabel.text = AppleWatchConnectivity.disconnectedLabel
        }
    }
    
    func activateWCSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
}
