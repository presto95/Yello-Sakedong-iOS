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
  
  var currentIndex: Int {
    get {
      return pageControl.currentPage
    }
    set {
      pageControl.currentPage = newValue
    }
  }
  
  private var keyboardInfo: KeyboardInfo!
  
  @IBOutlet private weak var backgroundView: UIView! {
    didSet {
      backgroundView.layer.applySketchShadow(
        color: .shadow,
        alpha: 0.5,
        x: 4,
        y: 3,
        blur: 12,
        spread: 0
      )
      backgroundView.clipsToBounds = true
      backgroundView.layer.cornerRadius = 6
    }
  }
  
  @IBOutlet private weak var registerButton: UIButton! {
    didSet {
      registerButton.addTarget(
        self,
        action: #selector(touchUpRegisterButton(_:)),
        for: .touchUpInside
      )
    }
  }
  
  @IBOutlet private weak var cancelButton: UIButton! {
    didSet {
      cancelButton.addTarget(
        self,
        action: #selector(touchUpCancelButton(_:)),
        for: .touchUpInside
      )
    }
  }
  
  @IBOutlet private weak var textView: UITextView!
  
  @IBOutlet private weak var pagerView: PopupFoodmojiView! {
    didSet {
      pagerView.delegate = self
      pagerView.dataSource = self
    }
  }
  
  @IBOutlet private weak var pageControl: FSPageControl! {
    didSet {
      pageControl.currentPage = 0
      pageControl.numberOfPages = 3
      pageControl.itemSpacing = 7
      pageControl.setFillColor(UIColor(rgb: 119), for: .selected)
      pageControl.setFillColor(UIColor(rgb: 216), for: .normal)
      pageControl.setStrokeColor(nil, for: [])
    }
  }
  
  @IBOutlet private weak var backgroundViewCenterYConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow(_:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide(_:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textView.becomeFirstResponder()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    setKeyboardInfo(notification)
    adjustPopupViewIfKeyboardWillShow()
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    adjustPopupViewIfKeyboardWillHide()
  }
  
  @objc private func touchUpRegisterButton(_ sender: UIButton) {
    // 맛 추가
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func touchUpCancelButton(_ sender: UIButton) {
    textView.resignFirstResponder()
    dismiss(animated: true, completion: nil)
  }
  
  private func setKeyboardInfo(_ notification: Notification) {
    let userInfo = notification.userInfo
    let frameUserInfo = userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
    let durationUserInfo = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
    let animationUserInfo = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey]
    guard let frameInfo = frameUserInfo as? CGRect else { return }
    guard let durationInfo = durationUserInfo as? NSNumber else { return }
    guard let animationInfo = animationUserInfo as? NSNumber else { return }
    let duration = durationInfo.doubleValue
    let animation = UIView.AnimationOptions(rawValue: UInt(truncating: animationInfo))
    keyboardInfo = KeyboardInfo(frame: frameInfo, duration: duration, animation: animation)
  }
  
  private func adjustPopupViewIfKeyboardWillShow() {
    UIView.animate(
      withDuration: keyboardInfo.duration,
      delay: 0,
      options: keyboardInfo.animation,
      animations: { [weak self] in
        guard let `self` = self else { return }
        self.backgroundViewCenterYConstraint.constant -= self.keyboardInfo.frame.height / 3
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  private func adjustPopupViewIfKeyboardWillHide() {
    UIView.animate(
      withDuration: keyboardInfo.duration,
      delay: 0,
      options: keyboardInfo.animation,
      animations: { [weak self] in
        guard let `self` = self else { return }
        self.backgroundViewCenterYConstraint.constant += self.keyboardInfo.frame.height / 3
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
}

extension PopupViewController: FSPagerViewDataSource {
  func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
    if let popupCell = cell as? PopupCell {
      
    }
    return cell
  }
  
  func numberOfItems(in pagerView: FSPagerView) -> Int {
    return 3
  }
}

extension PopupViewController: FSPagerViewDelegate {
  func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
    
  }
  
  func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
    currentIndex = targetIndex
  }
}
