//
//  ResultsVideoVC.swift
//  MC3-17
//
//  Created by Basit Tri Anggoro on 25/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class ResultsVideoVC: UIViewController{
    @IBOutlet weak var videoView: UIImageView!
    @IBOutlet weak var overview: UIView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rounded()
        shadow()
//        coloringTotalScoreCircle()
    }
    
    @IBAction func practiceBtnDidTapped(_ sender: UIButton) {
    }
    
    @IBAction func doneBtnDidTapped(_ sender: UIButton) {
    }
        
//    func coloringTotalScoreCircle(){
//        switch <#value#> {
//        case <#pattern#>:
//            totalScoreViewLarge.layer.backgroundColor = UIColor.systemPink.cgColor
//        case <#pattern#>:
//            totalScoreViewLarge.layer.backgroundColor = UIColor.systemYellow.cgColor
//        case <#pattern#>:
//            totalScoreViewLarge.layer.backgroundColor = UIColor.systemGreen.cgColor
//        default:
//            <#code#>
//        }
//    }
    
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

}

