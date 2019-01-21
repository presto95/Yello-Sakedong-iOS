//
//  PopupSelectView.swift
//  YelloSakedong
//
//  Created by Presto on 19/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import FSPagerView

class PopupSelectView: FSPagerView {
  
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
    interitemSpacing = 8
    register(PopupCell.self, forCellWithReuseIdentifier: "cell")
  }
}
