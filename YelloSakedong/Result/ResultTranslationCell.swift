//
//  ResultTranslationCell.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// ResultTranslationCell의 델리게이트 프로토콜.
protocol ResultTranslationCellDelegate: class {
  
  /// 좋아요 버튼을 탭했을 때의 동작.
  func resultTranslationCell(_ resultTranslationCell: ResultTranslationCell,
                             didTapLikeButton button: UIButton)
  
  /// 삭제 버튼을 탭했을 때의 동작.
  func resultTranslationCell(_ resultTranslationCell: ResultTranslationCell,
                             didTapDeleteButton button: UIButton)
  
}

/// 맛번역 테이블뷰 셀.
final class ResultTranslationCell: UITableViewCell {
  
  /// Delegate.
  weak var delegate: ResultTranslationCellDelegate?
  
  /// 상위 랭크에 있는 정보인지.
  /// 설정하는 경우 플래그 값에 따라 요소 색상을 변화시킴
  var isRanked: Bool {
    get {
      return _isRanked
    }
    set {
      _isRanked = newValue
      if newValue {
        likeButton.setTitleColor(.rankedTintColor, for: [])
        likeButton.tintColor = .rankedTintColor
      } else {
        likeButton.setTitleColor(.unrankedTintColor, for: [])
        likeButton.tintColor = .unrankedTintColor
      }
    }
  }
  
  /// 컬러칩 뷰가 숨겨져 있는지.
  /// `constraint`를 계산하여 구함.
  var hidesColorChipView: Bool {
    get {
      return colorChipViewWidthConstraint.constant == .leastNonzeroMagnitude
        && authorLabelLeadingConstraint.constant == .leastNonzeroMagnitude
    }
    set {
      if newValue {
        colorChipViewWidthConstraint.constant = .leastNonzeroMagnitude
        authorLabelLeadingConstraint.constant = .leastNonzeroMagnitude
      } else {
        colorChipViewWidthConstraint.constant = 10.0
        authorLabelLeadingConstraint.constant = 6.0
      }
    }
  }
  
  /// 삭제 버튼이 숨겨져 있는지.
  var hidesDeleteButton: Bool {
    get {
      return deleteButton.isHidden
    }
    set {
      deleteButton.isHidden = newValue
    }
  }
  
  /// 순위권에 있는지에 대한 플래그 값을 저장.
  private var _isRanked: Bool = false
  
  /// 컬러칩 뷰.
  @IBOutlet weak var colorChipView: UIView! {
    didSet {
      colorChipView.clipsToBounds = true
      colorChipView.layer.cornerRadius = colorChipView.bounds.height / 2
    }
  }
  
  /// 컬러칩 뷰 너비 제약.
  @IBOutlet private weak var colorChipViewWidthConstraint: NSLayoutConstraint!
  
  /// 작성자 레이블 리딩 제약.
  @IBOutlet private weak var authorLabelLeadingConstraint: NSLayoutConstraint!
  
  /// 좋아요 버튼 및 좋아요 수.
  @IBOutlet private weak var likeButton: UIButton! {
    didSet {
      likeButton.addTarget(self, action: #selector(likeButtonDidTap(_:)), for: .touchUpInside)
    }
  }
  
  /// 내가 올린 정보 삭제 버튼.
  @IBOutlet weak var deleteButton: UIButton! {
    didSet {
      deleteButton.addTarget(self, action: #selector(deleteButtonDidTap(_:)), for: .touchUpInside)
    }
  }
  
  /// 작성자 레이블.
  @IBOutlet private weak var authorLabel: UILabel!
  
  /// 설명 레이블.
  @IBOutlet private weak var descriptionLabel: UILabel!

  @objc private func likeButtonDidTap(_ sender: UIButton) {
    delegate?.resultTranslationCell(self, didTapLikeButton: sender)
  }
  
  @objc private func deleteButtonDidTap(_ sender: UIButton) {
    delegate?.resultTranslationCell(self, didTapDeleteButton: sender)
  }
}
