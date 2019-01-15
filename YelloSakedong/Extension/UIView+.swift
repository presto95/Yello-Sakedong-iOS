//
//  UIView+.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

public extension UIView {
    static func create(fromXib name: String) -> UIView? {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView
    }
}
