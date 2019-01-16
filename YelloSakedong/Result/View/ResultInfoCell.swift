//
//  ResultInfoCell.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

class ResultInfoCell: UITableViewCell {

    @IBOutlet private weak var emoticonImageView: UIImageView!
    
    @IBOutlet private weak var percentLabel: UILabel!
    
    @IBOutlet private weak var koreanLabel: UILabel!
    
    @IBOutlet private weak var nativeLabel: UILabel!
    
    @IBOutlet private weak var englishLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
