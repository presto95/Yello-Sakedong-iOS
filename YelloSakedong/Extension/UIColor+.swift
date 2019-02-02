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
    self.init(red: rgb, green: rgb, blue: rgb)
  }
  
  /// 그림자 색상.
  static let shadow = UIColor(rgb: 215)
  
  /// 순위권에 있는 요소들의 틴트 색상.
  static let rankedTintColor = UIColor(red: 255, green: 98, blue: 30)
  
  /// 순위권에 있는 정보의 배경 색상.
  static let rankedBackgroundColor = UIColor(red: 248, green: 249, blue: 251)
  
  /// 순위권에 잇는 요소들의 틴트 색상.
  static let unrankedTintColor = UIColor(rgb: 119)
  
  /// 내가 등록한 정보의 배경 색상.
  static let myBackgroundColor = UIColor(red: 255, green: 203, blue: 0)
}
