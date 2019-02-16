//
//  PopupSelectView.swift
//  YelloSakedong
//
//  Created by Presto on 19/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import FSPagerView

/// 팝업 뷰 컨트롤러의 푸드모지 페이저 뷰.
final class PopupFoodmojiPagerView: FSPagerView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    isInfinite = true
    itemSize = .init(width: bounds.width, height: bounds.height)
    interitemSpacing = .leastNonzeroMagnitude
    register(UINib(nibName: PopupFoodmojiPagerCell.classNameToString, bundle: nil),
             forCellWithReuseIdentifier: "cell")
  }
}
