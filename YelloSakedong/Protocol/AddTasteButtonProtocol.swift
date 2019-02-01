//
//  AddTaste.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// 맛추가 버튼이 들어갈 수 있는 타입 정의.
protocol AddTasteButtonProtocol: class {
  
  /// 맛추가 바 버튼 아이템.
  var addTasteButton: UIBarButtonItem { get }
  
  /// 맛추가 버튼 타겟.
  var addTasteButtonTarget: AddTasteButtonProtocol { get }
  
  /// 맛추가 버튼 액션.
  var addTasteButtonAction: Selector { get }
  
  /// 맛추가 탭할 때의 동작 정의.
  func addTasteButtonDidTap(_ sender: UIBarButtonItem)
}

extension AddTasteButtonProtocol {
  var addTasteButton: UIBarButtonItem {
    return UIBarButtonItem(
      image: Asset.addTaste.image,
      style: .plain,
      target: addTasteButtonTarget,
      action: addTasteButtonAction
    )
  }
}
