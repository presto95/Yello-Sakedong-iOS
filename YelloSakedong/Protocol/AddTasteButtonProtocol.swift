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
  var addTasteButton: UIBarButtonItem? { get }
  
  /// 맛추가 바 버튼 액션.
  var addTasteButtonAction: Selector? { get }
  
  /// 맛추가 탭할 때의 동작 정의.
  func addTasteButtonDidTap(_ sender: UIBarButtonItem)
  
  /// 맛추가 버튼을 내비게이션 바에 부착하기.
  func attachAddTasteButtonToNavigationBar()
  
  /// 팝업 뷰 컨트롤러 띄우기.
  func presentPopupViewController()
}

// MARK: - AddTasteButtonProtocol 프로토콜 초기 구현

extension AddTasteButtonProtocol where Self: UIViewController {
  var addTasteButton: UIBarButtonItem? {
    return UIBarButtonItem(
      image: Asset.addTaste.image,
      style: .plain,
      target: self,
      action: addTasteButtonAction
    )
  }
  
  func attachAddTasteButtonToNavigationBar() {
    navigationItem.rightBarButtonItem = addTasteButton
    navigationItem.backBarButtonItem = UIBarButtonItem()
  }
  
  func presentPopupViewController() {
    StoryboardScene.Popup.popupViewController
      .instantiate()
      .present(to: self)
  }
}
