//
//  PopupViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import FSPagerView

class PopupViewController: UIViewController {

    @IBOutlet private weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.applySketchShadow(color: .rgb215, alpha: 0.5, x: 4, y: 3, blur: 12, spread: 0)
            backgroundView.clipsToBounds = true
            backgroundView.layer.cornerRadius = 6
        }
    }
    
    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.addTarget(self, action: #selector(touchUpRegisterButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var cancelButton: UIButton! {
        didSet {
            cancelButton.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var textView: UITextView!
    
    @IBOutlet private weak var pagerView: FSPagerView!
    
    @IBOutlet private weak var pageControl: FSPageControl!
    
    @IBOutlet private weak var backgroundViewCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
    }
    
    @objc private func touchUpRegisterButton(_ sender: UIButton) {
        
    }
    
    @objc private func touchUpCancelButton(_ sender: UIButton) {
        textView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
