//
//  InfoPageViewController.swift
//  MC3-17
//
//  Created by Diana Ambarwati Febriani on 28/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class InfoPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startDrillingButton(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.toDrillingPage, sender: self)
    }
    

}
