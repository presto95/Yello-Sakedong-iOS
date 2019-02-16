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
protocol KeyboardObserverProtocol {
  
  /// 키보드가 보이려 할 때.
  func keyboardWillShow(_ notification: Notification)
  
  /// 키보드가 숨겨지려 할 때.
  func keyboardWillHide(_ notification: Notification)
  
  /// 키보드가 보여진 후에.
  func keyboardDidShow(_ notification: Notification)
  
  /// 키보드가 숨겨진 후에.
  func keyboardDidHide(_ notification: Notification)
  
  /// 키보드의 프레임이 변화하려 할 때.
  func keyboardWillChangeFrame(_ notification: Notification)
  
  /// 키보드의 프레임이 변화한 후에.
  func keyboardDidChangeFrame(_ notification: Notification)
  
  /// 키보드 노티피케이션 등록.
  func registerKeyboardNotifications()
  
  /// 키보드 노티피케이션 해제.
  func removeKeyboardNotifications()
}

// MARK: - 키보드 옵저버 프로토콜 초기 구현

extension KeyboardObserverProtocol where Self: UIViewController {
  
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
    let notificationCenter = NotificationCenter.default
    notificationCenter.removeObserver(self, name: .keyboardWillShow, object: nil)
    notificationCenter.removeObserver(self, name: .keyboardWillHide, object: nil)
    notificationCenter.removeObserver(self, name: .keyboardDidShow, object: nil)
    notificationCenter.removeObserver(self, name: .keyboardDidHide, object: nil)
    notificationCenter.removeObserver(self, name: .keyboardWillChangeFrame, object: nil)
    notificationCenter.removeObserver(self, name: .keyboardDidChangeFrame, object: nil)
  }
}
