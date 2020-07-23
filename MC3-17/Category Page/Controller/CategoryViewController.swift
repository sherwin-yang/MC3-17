//
//  CategoryViewController.swift
//  MC3-17
//
//  Created by Marsel Estefan Lie on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    let categories = [
        Category(categoryName: "Shots", categoryImage: "Shots", categoryDesc: "Learn the correct technique to execute these shots! By practice and practice!"),
        Category(categoryName: "Footwork", categoryImage: "Footwork", categoryDesc: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        let category = categories[indexPath.row]
        cell.categoryImage.image = UIImage(named: category.categoryImage!)
        cell.categoryName.text = category.categoryName
        
        cell.categoryImage.addShadow()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        performSegue(withIdentifier: "toShotsPage", sender: category)
        
    }
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destination = segue.destination as?
        ShotsViewController, let index =
        categoryCollection.indexPathsForSelectedItems?.first {
        destination.categoryNames = categories[index.row].categoryName
        destination.categoryDesc = categories[index.row].categoryDesc
    }
}
        }
        
