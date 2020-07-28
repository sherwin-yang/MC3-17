//
//  ResultOverviewViewController.swift
//  MC3-17
//
//  Created by Sherwin Yang on 27/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class ResultOverviewViewController: UIViewController {
    
    @IBOutlet var moveCategorySegmentedControl: UISegmentedControl!
    @IBOutlet var overviewTableView: UITableView!
    
    var movesCategory = [MoveCategory]()
    var goodMoves = [MoveCategory]()
    var badMoves = [MoveCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dummy()
        self.allocateGoodBadMoves()
    }
    
    func allocateGoodBadMoves() {
        goodMoves = MoveCategory.passGoodMoves(movesCategory)
        badMoves = MoveCategory.passBadMoves(movesCategory)
    }
    
    @IBAction func moveCategorySegmentedIndexChanged(_ sender: Any) {
        self.overviewTableView.reloadData()
    }
    
//    func dummy() {
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 30))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.badMove, time: 50))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 230))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 250))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.badMove, time: 300))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 430))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 550))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.badMove, time: 610))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 640))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 1000))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.goodMove, time: 3800))
//        movesCategory.append(MoveCategory(shotQuality: ShotQuality.badMove, time: 4600))
//    }
}

extension ResultOverviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moveCategorySegmentedControl.selectedSegmentIndex == 0 {
            return self.badMoves.count
        }
        
        return self.goodMoves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! ResultOverviewTableViewCell
        
        if moveCategorySegmentedControl.selectedSegmentIndex == 0 {
            cell.playImage.tintColor = UIColor(red: 228/256, green: 63/256, blue: 90/256, alpha: 1)
            cell.timeLabel.text = "\(badMoves[indexPath.row].time/3600):\(badMoves[indexPath.row].time%3600/60):\(badMoves[indexPath.row].time%3600%60)"
        }
        else if moveCategorySegmentedControl.selectedSegmentIndex == 1 {
            cell.playImage.tintColor = UIColor(red: 63/256, green: 228/256, blue: 98/256, alpha: 1)
            cell.timeLabel.text = "\(goodMoves[indexPath.row].time/3600):\(goodMoves[indexPath.row].time%3600/60):\(goodMoves[indexPath.row].time%3600%60)"
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
