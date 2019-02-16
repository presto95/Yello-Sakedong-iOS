//
//  KeyboardSubscriber.swift
//  YelloSakedong
//
//  Created by Presto on 05/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// 키보드 서브스크라이버 프로토콜.
protocol KeyboardSubscriberProtocol {
  
  /// 키보드가 보여지려 할 때를 구독함.
  func subscribeKeyboardWillShow(_ notification: Notification)
  
  /// 키보드가 숨겨지려 할 때를 구독함.
  func subscribeKeyboardWillHide(_ notification: Notification)
  
  /// 키보드가 보여진 후를 구독함.
  func subscribeKeyboardDidShow(_ notification: Notification)
  
  /// 키보드가 숨겨진 후를 구독함.
  func subscribeKeyboardDidHide(_ notification: Notification)
  
  /// 키보드의 프레임이 변화하려 할 때를 구독함.
  func subscribeKeyboardWillChangeFrame(_ notification: Notification)
  
  /// 키보드의 프레임이 변화한 후를 구독함.
  func subscribeKeyboardDidChangeFrame(_ notification: Notification)
}

// MARK: - 키보드 서브스크라이버 프로토콜 초기 구현

extension KeyboardSubscriberProtocol {
  
  func subscribeKeyboardWillShow(_ notification: Notification) { }
  
  func subscribeKeyboardWillHide(_ notification: Notification) { }
  
  func subscribeKeyboardDidShow(_ notification: Notification) { }
  
  func subscribeKeyboardDidHide(_ notification: Notification) { }
  
  func subscribeKeyboardWillChangeFrame(_ notification: Notification) { }
  
  func subscribeKeyboardDidChangeFrame(_ notification: Notification) { }
}
