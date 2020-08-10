//
//  InfoPageViewController.swift
//  MC3-17
//
//  Created by Diana Ambarwati Febriani on 28/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class InfoPageViewController: UIViewController {

//    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(navigationController?.viewControllers.count as Any)
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func backButton(_ sender: Any) {
//        if let vc = UIStoryboard(name: "InfoPage", bundle: nil).instantiateViewController(withIdentifier: "DrillPage") as? DrillViewController{
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
}
