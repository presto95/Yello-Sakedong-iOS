//
//  MainEmoticonView.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import SnapKit

/// 메인 화면의 레이블과 함께하는 이모티콘 뷰.
final class FoodmojiWithLabelView: UIView {
  
  /// 이모티콘 이미지 뷰.
  @IBOutlet private weak var foodmojiImageView: UIImageView!
  
  /// 이름 레이블.
  @IBOutlet private weak var nameLabel: UILabel! {
    didSet {
      nameLabel.clipsToBounds = true
      nameLabel.layer.cornerRadius = nameLabel.bounds.height / 2
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  /// 초기 설정.
  func setup(image: UIImage?, name: String?, color: UIColor?) {
    foodmojiImageView.image = image
    nameLabel.text = name
    nameLabel.textColor = color
  }
}
