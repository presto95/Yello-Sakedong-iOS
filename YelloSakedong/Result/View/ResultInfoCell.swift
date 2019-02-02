//
//  ResultInfoCell.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import Hero

/// 결과 화면에서 정보를 표시하는 테이블 뷰 셀.
final class ResultInfoCell: UITableViewCell {
  
  /// 음식 이미지 뷰.
  @IBOutlet private weak var foodImageView: UIImageView! {
    didSet {
      foodImageView.clipsToBounds = true
      foodImageView.layer.cornerRadius = foodImageView.bounds.height / 2
    }
  }
  
  /// 이모티콘 이미지 뷰.
  @IBOutlet private weak var foodmojiImageView: UIImageView! {
    didSet {
      foodmojiImageView.image = Foodmoji.Medium.image(at: Int.random(in: 0..<10))
      foodmojiImageView.hero.id = "emoticonButton"
    }
  }

  /// 한국어 음식명 레이블.
  @IBOutlet private weak var koreanLabel: UILabel!
  
  /// 현지어 음식명 레이블.
  @IBOutlet private weak var nativeLabel: UILabel!
  
  /// 영어 음식명 레이블.
  @IBOutlet private weak var englishLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    hero.isEnabled = true
  }
}
