//
//  KeyboardInfo.swift
//  YelloSakedong
//
//  Created by Presto on 19/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// 키보드 노티피케이션 관련 정보 정의.
struct KeyboardInfo {
  
  /// 키보드 프레임.
  let frame: CGRect
  
  /// 키보드 나타나고 사라지는 애니메이션의 동작 기간.
  let duration: Double
  
  /// 키보드 나타나고 사라지는 애니메이션의 옵션.
  let animation: UIView.AnimationOptions
}
