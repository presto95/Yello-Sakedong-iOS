//
//  ResultTranslationCell.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

class TranslationCell: UITableViewCell {

    @IBOutlet private weak var colorLabel: UILabel! {
        didSet {
            colorLabel.clipsToBounds = true
            colorLabel.layer.cornerRadius = colorLabel.bounds.height / 2
        }
    }
    
    @IBOutlet private weak var likeImageView: UIImageView!
    
    @IBOutlet private weak var likeCountLabel: UILabel!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
