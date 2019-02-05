//
//  PopupCell.swift
//  YelloSakedong
//
//  Created by Presto on 19/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import FSPagerView

/// 팝업 뷰 컨트롤러의 푸드모지 페이저 셀.
final class PopupFoodmojiPagerCell: FSPagerViewCell {
  
  /// 현재 셀 인덱스.
  var currentCellIndex: Int!
  
  /// 선택된 버튼의 스택 뷰 내 인덱스.
  var selectedButtonIndex: Int?
  
  /// 페이저 뷰 요소가 선택된 상태인가.
  var pagerViewHasSelected: Bool = false
  
  /// 스택 뷰에 들어가는 푸드모지 버튼들.
  private lazy var buttons: [UIButton] = {
    var buttons = [UIButton]()
    let startIndex = currentCellIndex * 5
    for index in startIndex..<startIndex + 5 {
      let button = UIButton(type: .system)
      if pagerViewHasSelected {
        if let selectedButtonIndex = selectedButtonIndex {
          button.setImage(Foodmoji.Small.Colored.image(at: selectedButtonIndex), for: [])
        } else {
          button.setImage(Foodmoji.Small.Uncolored.image(at: index), for: [])
        }
      } else {
        button.setImage(Foodmoji.Small.Colored.image(at: index), for: [])
      }
      button.imageView?.contentMode = .scaleAspectFit
      buttons.append(button)
    }
    return buttons
  }()
  
  override var reuseIdentifier: String? {
    return "cell"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func setup() {
    let stackView = UIStackView(arrangedSubviews: buttons)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = 8
    addSubview(stackView)
    stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
