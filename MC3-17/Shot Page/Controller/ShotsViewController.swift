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
        Shots(shotsName: "Drive", shotsImage: "Drive", shotsDesc: "Drive")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryName.text = categoryNames
        categoryDetail.text = categoryDesc
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DrillViewController,
            let index = shotsCollection.indexPathsForSelectedItems?.first {
            destination.drillName = shots[index.row].shotsName
        }
    }

}

extension ShotsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
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
        performSegue(withIdentifier: SegueIdentifier.toDrillPage, sender: shot)
    }
}
