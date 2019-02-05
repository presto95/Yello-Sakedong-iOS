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
  
  func subscribeKeyboardWillShow(_ notification: Notification)
  
  func subscribeKeyboardWillHide(_ notification: Notification)
  
  func subscribeKeyboardDidShow(_ notification: Notification)
  
  func subscribeKeyboardDidHide(_ notification: Notification)
  
  func subscribeKeyboardWillChangeFrame(_ notification: Notification)
  
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
