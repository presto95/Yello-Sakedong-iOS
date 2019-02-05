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
  
  /// PagerView 내에서의 인덱스.
  var cellIndex: Int!
  
  /// 선택된 버튼의 스택 뷰 내에서의 인덱스.
  var selectedButtonIndex: Int?
  
  /// 페이저 뷰 요소가 선택된 상태인가.
  var hasPagerViewSelected: Bool = false
  
  var foodmojiButtons: [UIButton] {
    return stackView.arrangedSubviews.compactMap { $0 as? UIButton }
  }
  
  @IBOutlet private weak var stackView: UIStackView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  func foodmojiButton(at index: Int) -> UIButton {
    return foodmojiButtons[index]
  }
}
