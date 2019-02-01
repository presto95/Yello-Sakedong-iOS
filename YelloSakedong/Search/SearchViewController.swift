//
//  SearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import Hero

/// 검색 뷰 컨트롤러.
final class SearchViewController: UIViewController {
  
  /// 셀 식별자 상수 정리.
  enum CellIdentifier {
    
    static let translationCell = "translationCell"
  }
  
  /// 키보드 관련 정보.
  private var keyboardInfo: KeyboardInfo!
  
  /// 이모티콘 버튼.
  private var foodmojiButton: UIButton! {
    didSet {
      foodmojiButton.alpha = 0
      // 샘플 이미지
      foodmojiButton.setImage(Foodmoji.Medium.first.image, for: [])
      foodmojiButton.imageView?.contentMode = .scaleAspectFit
      foodmojiButton.sizeToFit()
      let size = foodmojiButton.bounds.size
      foodmojiButton.bounds.size = .init(width: size.width - 20, height: size.height - 20)
      foodmojiButton.hero.id = "emoticonButton"
      foodmojiButton.addTarget(
        self,
        action: #selector(foodmojiButtonDidTap(_:)),
        for: .touchUpInside
      )
    }
  }
  
  @IBOutlet private weak var upperShadowView: UIView!
  
  @IBOutlet private weak var upperView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    navigationItem.rightBarButtonItem = addTasteButton
    foodmojiButton = UIButton(type: .system)
    navigationItem.backBarButtonItem = UIBarButtonItem()
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
    //searchTextField.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    //searchTextField.resignFirstResponder()
  }
  
  @objc private func searchTextFieldDidChange(_ sender: UITextField) {
    let text = sender.text ?? ""
    print(text)
    revealFoodmojiBehindKeyboard()
  }
  
  @objc private func foodmojiButtonDidTap(_ sender: UIButton) {
    StoryboardScene.Result.resultViewController
      .instantiate()
      .push(at: navigationController)
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    setKeyboardInfo(notification)
    adjustTableViewBottomConstraintIfKeyboardWillShow()
  }
  
  @objc private func keyboardWillHide(_ notificaton: Notification) {
    adjustTableViewBottomConstraintIfKeyboardWillHide()
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
  
  private func adjustTableViewBottomConstraintIfKeyboardWillShow() {
    UIView.animate(
      withDuration: keyboardInfo.duration,
      delay: 0,
      options: keyboardInfo.animation,
      animations: { [weak self] in
        guard let `self` = self else { return }
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  private func adjustTableViewBottomConstraintIfKeyboardWillHide() {
    UIView.animate(
      withDuration: keyboardInfo.duration,
      delay: 0,
      options:
      keyboardInfo.animation,
      animations: { [weak self] in
        guard let `self` = self else { return }
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  private func revealFoodmojiBehindKeyboard() {
    let centerPoint = CGPoint(x: view.bounds.width / 2, y: keyboardInfo.frame.origin.y)
    foodmojiButton.center = .init(x: centerPoint.x, y: centerPoint.y - 20)
    view.addSubview(foodmojiButton)
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      options: .curveEaseInOut,
      animations: {
        self.foodmojiButton.alpha = 1
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  private func dismissFoodmoji() {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      options: .curveEaseInOut,
      animations: {
        self.foodmojiButton.alpha = 0
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

// MARK: - AddTasteButtonProtocol 구현

extension SearchViewController: AddTasteButtonProtocol {
  var addTasteButtonTarget: AddTasteButtonProtocol {
    return self
  }
  
  var addTasteButtonAction: Selector {
    return #selector(addTasteButtonDidTap(_:))
  }
  
  @objc func addTasteButtonDidTap(_ sender: UIBarButtonItem) {
    StoryboardScene.Popup.popupViewController
      .instantiate()
      .present(to: self)
  }
}

private extension SearchViewController {
  
  /// arc 추가하기
  func addArc() {
    /// arc 베지어 곡선 만들기
    let path = UIBezierPath(
      arcCenter: .init(x: upperView.bounds.width / 2, y: 0),
      radius: upperView.bounds.height,
      startAngle: 0,
      endAngle: .pi,
      clockwise: true
    )
    // Shape Layer 만들고 상단 컨테이너 뷰의 마스크로 설정
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = UIColor.white.cgColor
    upperView.layer.mask = shapeLayer
    /// Shape Layer 만들고 그림자 효과 축하여 상단 그림자를 위한 뷰의 서브레이어에 추가
    let shadowLayer = CAShapeLayer()
    shadowLayer.path = path.cgPath
    shadowLayer.fillColor = UIColor.white.cgColor
    shadowLayer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 16, blur: 32, spread: 0)
    upperShadowView.layer.addSublayer(shadowLayer)
  }
}
