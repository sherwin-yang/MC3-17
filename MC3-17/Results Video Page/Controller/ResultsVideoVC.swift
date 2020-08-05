//
//  ResultsVideoVC.swift
//  MC3-17
//
//  Created by Basit Tri Anggoro on 25/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ResultsVideoVC: UIViewController{
    
    @IBOutlet weak var videoView: UIImageView!
    @IBOutlet weak var overview: UIView!
    @IBOutlet weak var badViewSmall: UIView!
    @IBOutlet weak var badViewLarge: UIView!
    @IBOutlet weak var goodViewSmall: UIView!
    @IBOutlet weak var goodViewLarge: UIView!
    @IBOutlet weak var totalScoreViewSmall: UIView!
    @IBOutlet weak var totalScoreViewLarge: UIView!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var practiceBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    var URIPATH: URL!
    var currentDuration = "00:00:00"
    var results: Result!
    var thumbnail: UIImage!

    let documentsFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        rounded()

        shadow()
        URIPATH = documentsFolder.appendingPathComponent("Content/Test.mp4")
        generateThumbnail()
        
        displayOverview()
        displayTotalScore()
        coloringTotalScore()
    }
    
    
    func deleteRecentFile(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("Content/Test.mp4") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("The file already exists at path, deleting and replacing with latest")
                if FileManager().isDeletableFile(atPath: filePath) {
                    do {
                        try FileManager().removeItem(at: pathComponent)
                        print("previous file deleted")
                    } catch {
                        print("current file could not be deleted")
                    }
                }
            } else {
                print("file belom keapus/ belom ada")
            }
        }
    }
    
    func generateThumbnail() {
        do{
            if let cekURL = URIPATH {
                let asset = AVURLAsset(url: cekURL)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                imageGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 1), actualTime: nil)
                thumbnail = UIImage(cgImage: cgImage)
//                thumbnail = thumbnail.rotate(radians: -.pi/2)! // Rotate 90 degrees
                videoView.image = thumbnail
            }
            else{
                return print("error generating thumbnail")
            }
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func playButtonPressed(){
        let player = AVPlayer(url: URIPATH)

        let playerController = AVPlayerViewController()
        playerController.player = player

        present(playerController, animated: true) {
            player.play()
        }
    }
    
    @IBAction func practiceBtnDidTapped(_ sender: UIButton) {
        deleteRecentFile()
        performSegue(withIdentifier: SegueIdentifier.toDrillPage, sender: Any?.self)
    }
    
    @IBAction func doneBtnDidTapped(_ sender: UIButton) {
        deleteRecentFile()
        performSegue(withIdentifier: SegueIdentifier.toCategoryPage, sender: Any?.self)
    }
    
    func shadow(){
        videoView.layer.shadowColor = UIColor.black.cgColor
        videoView.layer.shadowOpacity = 0.5
        videoView.layer.shadowOffset = CGSize(width: -0.5, height: 1)
        videoView.layer.shadowRadius = 1
    }
    
    func rounded(){
        videoView.layer.cornerRadius = 10
        overview.layer.cornerRadius = 10
        badViewLarge.layer.cornerRadius = badViewLarge.frame.size.height/2
        badViewSmall.layer.cornerRadius = badViewSmall.frame.size.height/2
        goodViewLarge.layer.cornerRadius = goodViewLarge.frame.size.height/2
        goodViewSmall.layer.cornerRadius = goodViewSmall.frame.size.height/2
        totalScoreViewLarge.layer.cornerRadius = totalScoreViewLarge.frame.size.height/2
        totalScoreViewSmall.layer.cornerRadius = totalScoreViewSmall.frame.size.height/2
        practiceBtn.layer.cornerRadius = 10
        doneBtn.layer.cornerRadius = 10
    }

    func displayOverview(){
        durationLabel.text = currentDuration
//        attemptsLabel.text =
//        badLabel.text =
//        goodLabel.text =
    }
    
    func displayTotalScore(){
//        totalScoreLabel.text =
    }
    
    func coloringTotalScore(){
        
    }
    
}
