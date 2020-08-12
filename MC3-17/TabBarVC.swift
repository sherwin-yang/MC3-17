//
//  TabBarVC.swift
//  MC3-17
//
//  Created by Marsel Estefan Lie on 12/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 108
        tabBar.frame.origin.y = view.frame.height - 108
    }

}
