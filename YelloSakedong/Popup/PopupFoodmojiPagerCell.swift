//
//  PopupCell.swift
//  YelloSakedong
//
//  Created by Presto on 19/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import FSPagerView

/// PopupFoodmojiPagerCell 델리게이트 프로토콜.
protocol PopupFoodmojiPagerCellDelegate: class {
  
  /// 특정 셀 내의 특정 버튼을 탭할 때의 동작.
  func popupFoodmojiPagerCell(_ popupFoodmojiPagerCell: PopupFoodmojiPagerCell,
                              didTapFoodmojiButton button: UIButton,
                              at buttonIndex: Int,
                              in pagerCellIndex: Int)
}

/// 팝업 뷰 컨트롤러의 푸드모지 페이저 셀.
final class PopupFoodmojiPagerCell: FSPagerViewCell {
  
  weak var delegate: PopupFoodmojiPagerCellDelegate?
  
  /// 페이저 뷰 내에서 해당 셀의 인덱스.
  var cellIndex: Int = 0

  /// 스택뷰 내 푸드모지 버튼들
  private var foodmojiButtons: [UIButton] {
    return stackView.arrangedSubviews.compactMap { $0 as? UIButton }
  }
  
  /// 푸드모지 스택 뷰.
  @IBOutlet private weak var stackView: UIStackView! {
    didSet {
      foodmojiButtons.forEach {
        $0.addTarget(self, action: #selector(foodmojiButtonDidTap(_:)), for: .touchUpInside)
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
   
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  /// 푸드모지 버튼이 탭되었을 때의 동작.
  @objc private func foodmojiButtonDidTap(_ sender: UIButton) {
    delegate?.popupFoodmojiPagerCell(self,
                                     didTapFoodmojiButton: sender,
                                     at: foodmojiButtons.firstIndex(of: sender) ?? 0,
                                     in: cellIndex)
  }
  
  /// 푸드모지 버튼 설정.
  func setFoodmojiButtons(selectedIndexOfPagerView: Int?, selectedIndexInPagerCell: Int?) {
    for (index, button) in foodmojiButtons.enumerated() {
      let imageIndex = cellIndex * 5 + index
      if let selectedIndexOfPagerView = selectedIndexOfPagerView,
        let selectedIndexInPagerCell = selectedIndexInPagerCell {
        button.setImage(Foodmoji.Small.Uncolored.image(at: imageIndex), for: [])
        if cellIndex == selectedIndexOfPagerView, index == selectedIndexInPagerCell {
          button.setImage(Foodmoji.Small.Colored.image(at: imageIndex), for: [])
        }
      } else {
        button.setImage(Foodmoji.Small.Colored.image(at: imageIndex), for: [])
      }
    }
  }
}
