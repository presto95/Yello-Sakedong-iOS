//
//  ResultInfoCell.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import Hero

protocol ResultInfoCellDelegate: class {
  
  func resultInfoCell(_ resultInfoCell: ResultInfoCell,
                      didTapAddButton button: UIButton)
}

/// 결과 화면에서 정보를 표시하는 테이블 뷰 셀.
final class ResultInfoCell: UITableViewCell {
  
  weak var delegate: ResultInfoCellDelegate?
  
  var foodImage: UIImage? {
    get {
      return foodImageView.image
    }
    set {
      foodImageView.image = newValue
      setState()
    }
  }
  
  var isFoodImageExists: Bool {
    return foodImageView.image != nil
  }
  
  var isFoodmojiExists: Bool = false {
    didSet {
      setState()
    }
  }
  
  @IBOutlet private weak var addImageButton: UIButton! {
    didSet {
      addImageButton.clipsToBounds = true
      addImageButton.layer.cornerRadius = addImageButton.bounds.height / 2
      addImageButton.addTarget(self,
                               action: #selector(didTapAddButton(_:)),
                               for: .touchUpInside)
    }
  }
  
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
    setState()
  }
  
  func setState() {
    if isFoodImageExists {
      addImageButton.backgroundColor = UIColor(red: 255, green: 193, blue: 40)
      addImageButton.isUserInteractionEnabled = false
      foodImageView.isHidden = false
    } else {
      addImageButton.backgroundColor = UIColor(rgb: 238)
      addImageButton.isUserInteractionEnabled = true
      foodImageView.isHidden = true
    }
    if isFoodmojiExists {
      foodmojiImageView.isHidden = false
    } else {
      foodmojiImageView.isHidden = true
    }
  }
  
  @objc private func didTapAddButton(_ sender: UIButton) {
    delegate?.resultInfoCell(self, didTapAddButton: sender)
  }
}
