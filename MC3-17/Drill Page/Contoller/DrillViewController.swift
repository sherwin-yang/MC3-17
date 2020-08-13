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
    
    var videoName: String?
    var thumbnail: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setVideo()
        self.generateThumbnail()
        self.drillCardView.addCardShadow()
        self.setAllLabels()
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
        DispatchQueue.main.async {
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
    }
    
    func setDescriptionLabel() {
        if SharedInfo.selectedDrill == DrillName.lob {
            self.descriptionLabel.text = DrillDescription.Long.lob
        }
        else if SharedInfo.selectedDrill == DrillName.smash {
            self.descriptionLabel.text = DrillDescription.Long.smash
        }
    }
    
    func generateThumbnail() {
            do{
                if let file = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
                    let asset = AVURLAsset(url: file)
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
    
    func setVideo() {
        if SharedInfo.selectedDrill == DrillName.lob {
            self.videoName = "Lob Video"
        }
    }
    
}
