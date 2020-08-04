//
//  CancelPopUpViewController.swift
//  MC3-17
//
//  Created by Diana Ambarwati Febriani on 03/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class CancelPopUpViewController: UIViewController {

    @IBOutlet var backView: UIView!
    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var imageCamera: UIImageView!
    @IBOutlet weak var buttonYes: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    @IBOutlet weak var labelSmall: UILabel!
    @IBOutlet weak var mainView: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        position()
        // Do any additional setup after loading the view.
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    

    func position(){
        labelQuestion.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        labelQuestion.layer.masksToBounds = true
        imageCamera.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        buttonNo.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        buttonYes.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        labelSmall.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        smallView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
//
//        backView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    }
    @IBAction func btnNo(_ sender: Any) {
        backView.isHidden = true
    }
    
}
