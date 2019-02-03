//
//  KeyboardObserving.swift
//  YelloSakedong
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardObserving: class {
  func keyboardWillShow(_ notification: Notification)
  func keyboardDidShow(_ notification: Notification)
  func keyboardWillHide(_ notification: Notification)
  func keyboardDidHide(_ notification: Notification)
}

extension KeyboardObserving where Self: UIViewController {
  
}
