//
//  ResultInfoCell.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import Hero
import EFCountingLabel

class ResultInfoCell: UITableViewCell {

    @IBOutlet private weak var emoticonImageView: UIImageView! {
        didSet {
            emoticonImageView.hero.id = "emoticonButton"
        }
    }
    
    @IBOutlet private weak var percentLabel: EFCountingLabel! {
        didSet {
            percentLabel.format = "%d%%"
            percentLabel.countFromZeroTo(65, withDuration: 0.7)
        }
    }
    
    @IBOutlet private weak var koreanLabel: UILabel!
    
    @IBOutlet private weak var nativeLabel: UILabel!
    
    @IBOutlet private weak var englishLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hero.isEnabled = true
    }
}
