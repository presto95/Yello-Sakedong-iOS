//
//  PopupViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet private weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.applySketchShadow(color: .rgb215, alpha: 0.5, x: 4, y: 3, blur: 12, spread: 0)
        }
    }
    
    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.addTarget(self, action: #selector(touchUpRegisterButton(_:)), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc private func touchUpRegisterButton(_ sender: UIButton) {
        
    }
}
