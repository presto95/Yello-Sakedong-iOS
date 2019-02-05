//
//  Notification+.swift
//  YelloSakedong
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation
import UIKit

extension Notification {
  
  var keyboardFrame: CGRect {
    return userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
  }
  
  var keyboardDuration: Double {
    return (userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
  }
  
  var keyboardAnimation: UIView.AnimationOptions {
    let rawValue = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber ?? .init()
    return UIView.AnimationOptions(rawValue: UInt(truncating: rawValue))
  }
}
