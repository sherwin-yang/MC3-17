//
//  CancelDrillingPopUpViewController.swift
//  MC3-17
//
//  Created by Diana Ambarwati Febriani on 09/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit
import WatchConnectivity

class CancelDrillingPopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueDrilling(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stopDrilling(_ sender: Any) {
        sendMessage(strMsg: "CANCEL")
        performSegue(withIdentifier: SegueIdentifier.toDrillPage, sender: self)
    }
    
    func sendMessage(strMsg: String){
        let message = ["instructionFromIos":strMsg]
        
        WCSession.default.sendMessage(message, replyHandler: nil) { (error) in
            
            print(error.localizedDescription)
            
        }
    }
    
}
