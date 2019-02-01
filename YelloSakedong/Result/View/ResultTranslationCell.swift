//
//  ResultTranslationCell.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// 맛번역 테이블뷰 셀.
final class ResultTranslationCell: UITableViewCell {
  
  /// 컬러칩 뷰가 숨겨져 있는지.
  /// `constraint`를 계산하여 구함.
  var hidesColorChipView: Bool {
    get {
      return colorChipViewWidthConstraint.constant == .leastNonzeroMagnitude
        && authorLabelLeadingConstraint.constant == .leastNonzeroMagnitude
    }
    set {
      if hidesColorChipView {
        colorChipViewWidthConstraint.constant = .leastNonzeroMagnitude
        authorLabelLeadingConstraint.constant = .leastNonzeroMagnitude
      } else {
        colorChipViewWidthConstraint.constant = 10.0
        authorLabelLeadingConstraint.constant = 6.0
      }
    }
  }
  
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
  
  /// 좋아요 이미지 뷰.
  @IBOutlet private weak var likeImageView: UIImageView!
  
  /// 좋아요 카운트 레이블.
  @IBOutlet private weak var likeCountLabel: UILabel!
  
  /// 작성자 레이블.
  @IBOutlet private weak var authorLabel: UILabel!
  
  /// 설명 레이블.
  @IBOutlet private weak var descriptionLabel: UILabel!
}
