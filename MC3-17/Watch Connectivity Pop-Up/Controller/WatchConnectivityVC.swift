//
//  WatchConnectivityVC.swift
//  MC3-17
//
//  Created by Basit Tri Anggoro on 11/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import WatchConnectivity

class WatchConnectivityVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tryAgainDidTapped(_ sender: Any) {
        if WCSession.default.isReachable == false {
            print("Disconnected")
        } else {
            print("Connected")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
