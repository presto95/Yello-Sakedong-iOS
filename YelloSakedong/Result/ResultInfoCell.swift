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
  
  /// 뷰 상태에 따른 설정.
  func setState() {
    if isFoodImageExists {
      // 음식 이미지가 존재하면
      // 음식 추가 버튼의 배경 색상을 노란색으로 하고 백그라운드 이미지를 없애며, 사용자 입력을 받지 않도록 한다.
      // 음식 이미지 뷰를 나타낸다.
      addImageButton.backgroundColor = UIColor(red: 255, green: 193, blue: 40)
      addImageButton.setBackgroundImage(nil, for: [])
      addImageButton.isUserInteractionEnabled = false
      foodImageView.isHidden = false
    } else {
      // 음식 이미지가 존재하지 않으면
      // 음식 추가 버튼의 배경 색상을 없애고 백그라운드 이미지를 설정하며, 사용자 입력을 받도록 한다.
      // 음식 이미지 뷰를 숨긴다.
      addImageButton.backgroundColor = nil
      addImageButton.setBackgroundImage(Asset.addImage.image, for: [])
      addImageButton.isUserInteractionEnabled = true
      foodImageView.isHidden = true
    }
    if isFoodmojiExists {
      // 푸드모지가 존재하면
      // 푸드모지 이미지 뷰를 나타낸다.
      foodmojiImageView.isHidden = false
    } else {
      // 푸드모지가 존재하지 않으면
      // 푸드모지 이미지 뷰를 숨긴다.
      foodmojiImageView.isHidden = true
    }
  }
  
  /// 이미지 추가 버튼을 눌렀을 때의 동작 정의.
  @objc private func didTapAddButton(_ sender: UIButton) {
    delegate?.resultInfoCell(self, didTapAddButton: sender)
  }
}
