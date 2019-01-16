//
//  SearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import Hero

class SearchViewController: UIViewController {

    @IBOutlet private weak var upperView: UIView! {
        didSet {
            upperView.hero.id = "upperView"
            upperView.hero.modifiers = [.arc]
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        hero.modalAnimationType = .none
    }
}
