//
//  CardShadow.swift
//  MC3-17
//
//  Created by Sherwin Yang on 21/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

extension UIView {
    
    func addCardShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: 1, height: 2)
        layer.shadowRadius = 5
    }
    
    func appleWatchMarkColor(connectivity: String) {
        if connectivity == AppleWatchConnectivity.connected {
            layer.backgroundColor = CGColor(srgbRed: 52/256, green: 199/256, blue: 89/256, alpha: 1)
        }
        else if connectivity == AppleWatchConnectivity.disonnected {
            layer.backgroundColor = CGColor(srgbRed: 193/256, green: 58/256, blue: 58/256, alpha: 1)
        }
    }
}
