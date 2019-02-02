//
//  MainSearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// 첫 화면 뷰 컨트롤러.
final class MainViewController: UIViewController {
  
  /// 키보드 정보 관련 구조체.
  private var keyboardInfo: KeyboardInfo!
  
  /// 푸드모지 버튼.
  private var foodmojiButton: UIButton!
  
  // MARK: IBOutlet
  
  /// 상단 그림자를 넣기 위한 뷰.
  @IBOutlet private weak var upperShadowView: UIView!
  
  /// 상단 컨테이너 뷰.
  @IBOutlet private weak var upperView: UIView! {
    didSet {
      upperView.addGestureRecognizer(
        UITapGestureRecognizer(target: self, action: #selector(upperViewDidTap(_:)))
      )
      addArc()
    }
  }
  
  /// 상단 컨테이너 뷰 위쪽 제약.
  @IBOutlet private weak var upperViewTopConstraint: NSLayoutConstraint!
  
  /// 하단 컨테이너 뷰.
  @IBOutlet private weak var lowerView: UIView!
  
  /// 맛이 궁금한 음식을 입력받는 텍스트 필드.
  @IBOutlet private weak var foodTextField: UITextField! {
    didSet {
      foodTextField.delegate = self
      foodTextField.addTarget(self,
                              action: #selector(foodTextFieldTextDidChange),
                              for: .editingChanged)
    }
  }
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    navigationController?.hero.isEnabled = true
    navigationController?.hero.navigationAnimationType = .fade
    navigationItem.rightBarButtonItem = addTasteButton
    navigationItem.backBarButtonItem = UIBarButtonItem()
    initializeFoodmojiButton()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow(_:)),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide(_:)),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    // 최초에 화면이 보여질 때만 arc를 레이어에 추가
    if isBeingPresented || isMovingToParent {
      addArc()
    }
//    StoryboardScene.Main.progressViewController
//      .instantiate()
//      .present(to: self)
  }
  
  /// 상단 뷰를 탭했을 때의 동작.
  @objc private func upperViewDidTap(_ recognizer: UITapGestureRecognizer) {
    foodTextField.becomeFirstResponder()
  }
  
  /// 텍스트 필드 입력이 바뀌었을 때의 동작.
  @objc private func foodTextFieldTextDidChange(_ textField: UITextField) {
    
  }
  
  /// 푸드모지 버튼 클릭시 동작.
  @objc private func foodmojiButtonDidTap(_ sender: UIButton) {
    StoryboardScene.Main.progressViewController
      .instantiate()
      .present(to: self)
  }
  
  /// 키보드가 나타나려 할 때의 동작.
  @objc private func keyboardWillShow(_ notification: Notification) {
    setKeyboardInfo(notification)
    revealFoodmojiButton()
  }
  
  /// 키보드가 내려가려 할 때의 동작.
  @objc private func keyboardWillHide(_ notification: Notification) {
    dismissFoodmojiButton()
  }
  
  /// 푸드모지 버튼 초기화.
  private func initializeFoodmojiButton() {
    foodmojiButton = UIButton(type: .system)
    foodmojiButton.alpha = 0
    foodmojiButton.setImage(Foodmoji.Large.tenth.image, for: [])
    foodmojiButton.imageView?.contentMode = .scaleAspectFit
    foodmojiButton.sizeToFit()
    foodmojiButton.addTarget(self,
                             action: #selector(foodmojiButtonDidTap(_:)),
                             for: .touchUpInside)
  }
  
  /// 키보드 관련 정보 설정.
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
  
  /// 푸드모지 버튼 드러내기.
  private func revealFoodmojiButton() {
    let center = CGPoint(x: view.bounds.width / 2, y: keyboardInfo.frame.origin.y)
    foodmojiButton.center = .init(x: center.x, y: center.y - 20)
    foodmojiButton.alpha = 1
    view.addSubview(foodmojiButton)
  }
  
  /// 푸드모지 버튼 숨기기.
  private func dismissFoodmojiButton() {
    foodmojiButton.alpha = 0
    foodmojiButton.removeFromSuperview()
  }
}

// MARK: - AddTasteButtonProtocol 구현

extension MainViewController: AddTasteButtonProtocol {
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

// MARK: - UITextFieldDelegate 구현

extension MainViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // 상단 뷰 약간 위로 올라가며 입력 받을 준비
   
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    // 초기 상태로 돌아가기
    textField.text = nil
    //textField.resignFirstResponder()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - Private Extension

private extension MainViewController {
  
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
