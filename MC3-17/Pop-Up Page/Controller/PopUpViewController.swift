//
//  PopUpViewController.swift
//  MC3-17
//
//  Created by Sherwin Yang on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var drillName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "", sender: self)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "", sender: self)
    }
    
}
