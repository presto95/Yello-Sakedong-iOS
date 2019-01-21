//
//  PopupCell.swift
//  YelloSakedong
//
//  Created by Presto on 19/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import FSPagerView

class PopupCell: FSPagerViewCell {
  
  private lazy var buttons: [UIButton] = {
    var buttons = [UIButton]()
    for index in 0..<5 {
      let button = UIButton(type: .system)
      button.setImage(UIImage(named: "sample"), for: [])
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
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
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
