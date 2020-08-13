//
//  ShotsViewController.swift
//  MC3-17
//
//  Created by Marsel Estefan Lie on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class ShotsViewController: UIViewController {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDetail: UILabel!
    @IBOutlet var shotsCollection: UICollectionView!
    
    var categoryNames: String?
    var categoryDesc: String?
    
    let shots = [
        Shots(shotsName: DrillName.lob, shotsImage: "Shots", shotsDesc: "Lob shot is a shots aim to lift the shuttlecock, so it can give time to get back to the ready position"),
        Shots(shotsName: DrillName.drive, shotsImage: "Shots", shotsDesc: "Drive is an attacking shot in which the shuttlecock is hit so fast that the opponent barely has time to react"),
        Shots(shotsName: DrillName.smash, shotsImage: "Shots", shotsDesc: "Smash is the most powerfull shots in badminton, the aim of this shots is mostly to score a direct point"),
        Shots(shotsName: DrillName.dropshot, shotsImage: "Shots", shotsDesc: "Dropshot is a stroke that falls, or drops, directly behind the net, hence the name"),
        Shots(shotsName: DrillName.netshot, shotsImage: "Shots", shotsDesc: "Netshot is a shot that is performed from the front of the court, near the net, to the front of the court of your opponent")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryName.text = categoryNames
        categoryDetail.text = categoryDesc
    }

}

extension ShotsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shotsCell", for: indexPath) as! ShotsCell

        cell.cellsView.addCardShadow()
        cell.shotsImage.image = UIImage(named: shots[indexPath.row].shotsImage!)
        cell.shotsName.text = shots[indexPath.row].shotsName
        cell.shotsDesc.text = shots[indexPath.row].shotsDesc

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shot = shots[indexPath.row]
        SharedInfo.selectedDrill = shot.shotsName
        
        let alert = UIAlertController(title: "", message: "This feature is still under development", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        if indexPath.row > 0 {
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: SegueIdentifier.toDrillPage, sender: shot)
        }
    }
}
