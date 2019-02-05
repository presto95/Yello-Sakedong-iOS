//
//  KeyboardObservable.swift
//  YelloSakedong
//
//  Created by Presto on 05/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation
import UIKit

/// 키보드 옵저버 프로토콜.
protocol KeyboardObserver {
  
  func keyboardWillShow(_ notification: Notification)
  
  func keyboardWillHide(_ notification: Notification)
  
  func keyboardDidShow(_ notification: Notification)
  
  func keyboardDidHide(_ notification: Notification)
  
  func keyboardWillChangeFrame(_ notification: Notification)
  
  func keyboardDidChangeFrame(_ notification: Notification)
  
  func registerKeyboardNotifications()
  
  func removeKeyboardNotifications()
}

// MARK: - 키보드 옵저버 프로토콜 초기 구현

extension KeyboardObserver where Self: UIViewController {
  
  func keyboardWillShow(_ notification: Notification) { }
  
  func keyboardWillHide(_ notification: Notification) { }
  
  func keyboardDidShow(_ notification: Notification) { }
  
  func keyboardDidHide(_ notification: Notification) { }
  
  func keyboardWillChangeFrame(_ notification: Notification) { }
  
  func keyboardDidChangeFrame(_ notification: Notification) { }
  
  func registerKeyboardNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(forName: .keyboardWillShow, object: nil, queue: nil) {
      self.keyboardWillShow($0)
    }
    notificationCenter.addObserver(forName: .keyboardWillHide, object: nil, queue: nil) {
      self.keyboardWillHide($0)
    }
    notificationCenter.addObserver(forName: .keyboardDidShow, object: nil, queue: nil) {
      self.keyboardDidShow($0)
    }
    notificationCenter.addObserver(forName: .keyboardDidHide, object: nil, queue: nil) {
      self.keyboardDidHide($0)
    }
    notificationCenter.addObserver(forName: .keyboardWillChangeFrame, object: nil, queue: nil) {
      self.keyboardWillChangeFrame($0)
    }
    notificationCenter.addObserver(forName: .keyboardDidChangeFrame, object: nil, queue: nil) {
      self.keyboardDidChangeFrame($0)
    }
  }
  
  func removeKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .keyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .keyboardWillHide, object: nil)
    NotificationCenter.default.removeObserver(self, name: .keyboardDidShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .keyboardDidHide, object: nil)
    NotificationCenter.default.removeObserver(self, name: .keyboardWillChangeFrame, object: nil)
    NotificationCenter.default.removeObserver(self, name: .keyboardDidChangeFrame, object: nil)
  }
}
