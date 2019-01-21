//
//  MainEmoticonView.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import SnapKit

class EmoticonWithLabelView: UIView {
  
  private var emoticonImageView: UIImageView!
  
  private var nameLabel: UILabel!
  
  var emoticonImage: UIImage? {
    get {
      return emoticonImageView.image
    }
    set {
      emoticonImageView.image = newValue
    }
  }
  
  var name: String? {
    get {
      return nameLabel.text
    }
    set {
      nameLabel.text = newValue
    }
  }
  
  var color: UIColor? {
    get {
      return nameLabel.textColor
    }
    set {
      nameLabel.textColor = newValue
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  convenience init(frame: CGRect, emoticonImage: UIImage?, name: String?, color: UIColor?) {
    self.init(frame: frame)
    self.emoticonImage = emoticonImage
    self.name = name
    self.color = color
  }
  
  private func setup() {
    emoticonImageView = .init(frame: .zero)
    nameLabel = .init(frame: .zero)
    addSubview(emoticonImageView)
    addSubview(nameLabel)
    emoticonImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      //$0.top.equalToSuperview()
      //$0.leading.equalToSuperview()
      //$0.trailing.equalToSuperview()
      //$0.height.equalTo(emoticonImageView.snp.width)
    }
    nameLabel.snp.makeConstraints {
      //$0.top.equalTo(emoticonImageView.snp.bottom)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.3)
    }
    emoticonImageView.clipsToBounds = true
    emoticonImageView.layer.cornerRadius = emoticonImageView.bounds.height / 2
    nameLabel.clipsToBounds = true
    nameLabel.layer.cornerRadius = nameLabel.bounds.height / 2
  }
}
