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
            let button = UIButton()
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(UIImage(named: "sample"), for: [])
            buttons.append(UIButton(type: .system))
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
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
    }
}
