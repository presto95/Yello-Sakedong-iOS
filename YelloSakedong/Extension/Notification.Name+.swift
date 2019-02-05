//
//  Notification.Name+.swift
//  YelloSakedong
//
//  Created by Presto on 05/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
  
  static let keyboardWillShow = UIResponder.keyboardWillShowNotification
  
  static let keyboardWillHide = UIResponder.keyboardWillHideNotification
  
  static let keyboardDidShow = UIResponder.keyboardDidShowNotification
  
  static let keyboardDidHide = UIResponder.keyboardDidHideNotification
  
  static let keyboardWillChangeFrame = UIResponder.keyboardWillChangeFrameNotification
  
  static let keyboardDidChangeFrame = UIResponder.keyboardDidChangeFrameNotification
}
