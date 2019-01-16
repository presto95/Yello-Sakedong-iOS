//
//  UIColor+.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    convenience init(rgb: CGFloat) {
        self.init(red: rgb / 255, green: rgb / 255, blue: rgb / 255)
    }
    
    static let rgb215 = UIColor(rgb: 215)
}
