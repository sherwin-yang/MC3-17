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
        print(navigationController?.viewControllers.count)
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
//        performSegue(withIdentifier: SegueIdentifier.toCameraScreen, sender: self)
        
        let alert = UIAlertController(title: "", message: "This feature is still under development", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifier.toInfoPage, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == SegueIdentifier.toCameraScreen {
                if let destination = segue.destination as? CameraVC {
                    
                }
            }
        }
    }
    
}
