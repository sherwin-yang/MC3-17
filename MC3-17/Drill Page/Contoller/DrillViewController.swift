//
//  DrillViewController.swift
//  MC3-17
//
//  Created by Sherwin Yang on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import AVKit

class DrillViewController: UIViewController {

    @IBOutlet var drillCardView: UIView!
    @IBOutlet var drillNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var totalAttemptsLabel: UILabel!
    @IBOutlet var badMovesLabel: UILabel!
    @IBOutlet var goodMovesLabel: UILabel!
    @IBOutlet var highestScoreLabel: UILabel!
    
    var drillName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drillCardView.addCardShadow()
        self.setAllLabels()
    }
    
    @IBAction func playVideoButton(_ sender: Any) {
        if let path = Bundle.main.path(forResource: "video", ofType: "mov") {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true) {
                video.play()
            }
        }
    }
    
    func setAllLabels() {
        if drillName != nil {
            self.drillNameLabel.text = drillName
            self.setDescriptionLabel()
            self.totalAttemptsLabel.text = String(Drill.countTotalAttempts(drillName!))
            if Drill.countTotalAttempts(drillName!) != 0 {
                self.badMovesLabel.text = String(Drill.countBadMoves(drillName!))
                self.goodMovesLabel.text = String(Drill.countGoodMoves(drillName!))
                self.highestScoreLabel.text = String(Drill.findHighestScore(drillName!))
            }
        }
    }
    
    func setDescriptionLabel() {
        if drillName == DrillName.lob {
            self.descriptionLabel.text = DrillDescription.lob
        }
        else if drillName == DrillName.smash {
            self.descriptionLabel.text = DrillDescription.smash
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == SegueIdentifier.toPopUpScreen {
                if let destination = segue.destination as? PopUpViewController {
                    destination.drillName = drillName
                }
            }
        }
    }

}
