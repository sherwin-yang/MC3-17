//
//  ShotsViewController.swift
//  MC3-17
//
//  Created by Marsel Estefan Lie on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class ShotsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDetail: UILabel!
    @IBOutlet weak var shotsCollection: UICollectionView!
    
    var categoryNames: String?
    var categoryDesc: String?
    
    let shots = [
        Shots(shotsName: "Lob / Clear", shotsImage: "Shots", shotsDesc: "Lob shot is a shots aim to lift the shuttlecock, so it can give time to get back to the ready position"),
        Shots(shotsName: "Drive", shotsImage: "Drive", shotsDesc: "Drive")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryName.text = categoryNames
        categoryDetail.text = categoryDesc
        
        shotsCollection.delegate = self
        shotsCollection.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shotsCollection.dequeueReusableCell(withReuseIdentifier: "shotsCell", for: indexPath) as! ShotsCell

        let shot = shots[indexPath.row]
        cell.shotsImage.image = UIImage(named: shot.shotsImage!)
        cell.shotsName.text = shot.shotsName
        cell.shotsDesc.text = shot.shotsDesc
        
        cell.shotsImage.addShadow()

        return cell
    }

}
