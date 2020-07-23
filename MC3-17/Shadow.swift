//
//  Shadow.swift
//  MC3-17
//
//  Created by Marsel Estefan Lie on 23/07/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: 1, height: 2)
        layer.shadowRadius = 8
    }
}
