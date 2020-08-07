//
//  ResultsNoVideoVC.swift
//  MC3-17
//
//  Created by Basit Tri Anggoro on 25/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class ResultNoVideoVC: UIViewController {

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var overviewLabel: UIView!
    @IBOutlet weak var badViewSmall: UIView!
    @IBOutlet weak var badViewLarge: UIView!
    @IBOutlet weak var goodViewSmall: UIView!
    @IBOutlet weak var goodViewLarge: UIView!
    @IBOutlet weak var totalScoreViewSmall: UIView!
    @IBOutlet weak var totalScoreViewLarge: UIView!
    
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var practiceBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    var results: Result!
    var duration: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rounded()
        shadow()
        attemptsLabel.text = "\(results.countTotalAttempts())"
        durationLabel.text = "\(countTimerHour()):\(countTimerMinute()):\(countTimerSecond())"
        goodLabel.text = "\(results.countGoodMoves())"
        badLabel.text = "\(results.countBadMoves())"
        totalScoreLabel.text = "\(results.countScoreResult())"
        
//        coloringTotalScoreCircle()
    }
    
    @IBAction func practiceBtnDidTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifier.toDrillPage, sender: self)
    }
    
    @IBAction func doneBtnDidTapped(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.toCategoryPage, sender: self)
    }
    
    func shadow(){
        videoView.layer.shadowColor = UIColor.black.cgColor
        videoView.layer.shadowOpacity = 0.5
        videoView.layer.shadowOffset = CGSize(width: -0.5, height: 1)
        videoView.layer.shadowRadius = 1
    }
    
    func rounded(){
        videoView.layer.cornerRadius = 10
        overviewLabel.layer.cornerRadius = 10
//        badViewLarge.layer.cornerRadius = badViewLarge.frame.size.height/2
//        badViewSmall.layer.cornerRadius = badViewSmall.frame.size.height/2
//        goodViewLarge.layer.cornerRadius = goodViewLarge.frame.size.height/2
//        goodViewSmall.layer.cornerRadius = goodViewSmall.frame.size.height/2
//        totalScoreViewLarge.layer.cornerRadius = totalScoreViewLarge.frame.size.height/2
//        totalScoreViewSmall.layer.cornerRadius = totalScoreViewSmall.frame.size.height/2
        practiceBtn.layer.cornerRadius = 10
        doneBtn.layer.cornerRadius = 10
    }
    
    func countTimerHour() -> String {
        if duration/3600 < 10 {
            return "0\(duration/3600)"
        }
        else {
            return "\(duration/3600)"
        }
    }
    
    func countTimerMinute() -> String {
        if duration%3600/60 < 10 {
            return "0\(duration%3600/60)"
        }
        else {
            return "\(duration%3600/60)"
        }
    }
    
    func countTimerSecond() -> String {
        if duration%3600%60 < 10 {
            return "0\(duration%3600%60)"
        }
        else {
            return "\(duration%3600%60)"
        }
    }
    
}

//extension UINavigationController {
//  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
//    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
//      popToViewController(vc, animated: animated)
//    }
//  }
//}
