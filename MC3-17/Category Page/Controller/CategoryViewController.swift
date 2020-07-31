//
//  CategoryViewController.swift
//  MC3-17
//
//  Created by Marsel Estefan Lie on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    let categories = [
        Category(categoryName: "Shots", categoryImage: "Shots", categoryDesc: "Learn the correct technique to execute these shots! By practice and practice!"),
        Category(categoryName: "Footwork", categoryImage: "Footwork", categoryDesc: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShotsViewController,
            let index = categoryCollection.indexPathsForSelectedItems?.first {
            destination.categoryNames = categories[index.row].categoryName
            destination.categoryDesc = categories[index.row].categoryDesc
        }
    }
}

extension CategoryViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        cell.categoryImage.image = UIImage(named: categories[indexPath.row].categoryImage!)
        cell.categoryName.text = categories[indexPath.row].categoryName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        performSegue(withIdentifier: SegueIdentifier.toShotsPage, sender: category)
    }
}
