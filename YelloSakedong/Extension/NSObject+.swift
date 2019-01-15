//
//  NSObject+.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

public extension NSObject {
    var classNameToString: String {
        return NSStringFromClass(type(of: self))
    }
    
    static var classNameToString: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
