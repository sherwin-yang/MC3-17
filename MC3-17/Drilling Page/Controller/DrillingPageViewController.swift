//
//  DrillingPageViewController.swift
//  MC3-17
//
//  Created by Diana Ambarwati Febriani on 28/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class DrillingPageViewController: UIViewController {
    @IBOutlet weak var hoursText: UILabel!
    @IBOutlet weak var minuteText: UILabel!
    @IBOutlet weak var secondsText: UILabel!
    
    var hours = 0
    var minutes = 0
    var seconds = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
    }
    
    @objc func count() {
        seconds += 1
        if seconds == 60 {
            minutes += 1
            seconds = 0
            
        } else if minutes == 60 {
            hours += 1
            minutes = 0
            seconds = 0
        }
        
        //Show Timer Text
        if seconds < 10 {
            secondsText.text = "0\(seconds)"
        } else {
            secondsText.text = "\(seconds)"
        }
        
        if minutes < 10 {
            minuteText.text = "0\(minutes)"
        } else {
            minuteText.text = "\(minutes)"
        }
       
        if hours < 10 {
            hoursText.text = "0\(hours)"
        } else {
            hoursText.text = "\(hours)"
        }
    }
        
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
