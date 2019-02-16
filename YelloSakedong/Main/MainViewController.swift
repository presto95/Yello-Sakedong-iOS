//
//  MainSearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import Hero
import Then

/// 첫 화면 뷰 컨트롤러.
final class MainViewController: UIViewController {
  
  /// 푸드모지 애니메이션 관련 상수 정의.
  enum FoodmojiAnimation {
    
    static let duration: TimeInterval = 0.5
    
    static let delay: TimeInterval = 0.0
    
    static let damping: CGFloat = 0.6
    
    static let springVelocity: CGFloat = 0.5
    
    static let animation: UIView.AnimationOptions = [.curveEaseInOut]
  }
  
  /// 푸드모지 버튼.
  private var foodmojiButton: UIButton!
  
  // MARK: IBOutlet
  
  /// 상단 그림자를 넣기 위한 뷰.
  @IBOutlet private weak var upperView: UIView! {
    didSet {
      upperView.addGestureRecognizer(
        UITapGestureRecognizer(target: self, action: #selector(upperViewDidTap(_:)))
      )
    }
  }
  
  /// 상단 그림자 뷰 높이 제약.
  @IBOutlet private weak var upperViewHeightConstraint: NSLayoutConstraint!
  
  /// 하단 컨테이너 뷰.
  @IBOutlet private weak var lowerView: UIView!
  
  /// 맛이 궁금한 음식을 입력받는 텍스트 필드.
  @IBOutlet private weak var foodTextField: UITextField! {
    didSet {
      foodTextField.delegate = self
      foodTextField.addTarget(
        self,
        action: #selector(foodTextFieldTextDidChange),
        for: .editingChanged
      )
    }
  }
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    hero.modalAnimationType = .fade
    navigationController?.hero.isEnabled = true
    navigationController?.hero.navigationAnimationType = .fade
    attachAddTasteButtonToNavigationBar()
    initializeFoodmojiButton()
    registerKeyboardNotifications()
  }
  
  deinit {
    removeKeyboardNotifications()
  }
  
  // MARK: @objc Method
  
  /// 상단 뷰를 탭했을 때의 동작.
  @objc private func upperViewDidTap(_ recognizer: UITapGestureRecognizer) {
    foodTextField.becomeFirstResponder()
  }
  
  /// 텍스트 필드 입력이 바뀌었을 때의 동작.
  @objc private func foodTextFieldTextDidChange(_ textField: UITextField) {
    if let isEmpty = textField.text?.isEmpty, !isEmpty {
      foodmojiButton.isEnabled = true
    } else {
      foodmojiButton.isEnabled = false
    }
  }
  
  /// 푸드모지 버튼 클릭시 동작.
  @objc private func foodmojiButtonDidTap(_ sender: UIButton) {
    StoryboardScene.Main.progressViewController
      .instantiate()
      .present(to: self)
  }
  
  // MARK: Private Method
  
  /// 푸드모지 버튼 초기화.
  private func initializeFoodmojiButton() {
    let keyboardCenter: CGPoint = .init(x: UIScreen.main.bounds.width / 2,
                                        y: UIScreen.main.bounds.height)
    foodmojiButton = UIButton(type: .system).then {
      $0.isEnabled = false
      $0.alpha = 0
      $0.setImage(Foodmoji.Large.tenth.image, for: [])
      $0.imageView?.contentMode = .scaleAspectFit
      $0.sizeToFit()
      $0.transform = .init(scaleX: 0.1, y: 0.1)
      $0.center = keyboardCenter
      $0.addTarget(self, action: #selector(foodmojiButtonDidTap(_:)), for: .touchUpInside)
      
    }
  }
  
  /// 푸드모지 버튼 드러내기.
  private func revealFoodmojiButton(_ notification: Notification) {
    let foodmojiButtonCenter = CGPoint(
      x: view.bounds.width / 2,
      y: view.bounds.height - notification.keyboardFrame.height - 20
    )
    foodmojiButton.center = foodmojiButtonCenter
    UIView.animate(
      withDuration: FoodmojiAnimation.duration,
      delay: FoodmojiAnimation.delay,
      usingSpringWithDamping: FoodmojiAnimation.damping,
      initialSpringVelocity: FoodmojiAnimation.springVelocity,
      options: FoodmojiAnimation.animation,
      animations: { [weak self] in
        guard let self = self else { return }
        self.foodmojiButton.transform = .identity
        self.foodmojiButton.alpha = 1
      },
      completion: nil
    )
    view.addSubview(foodmojiButton)
  }
  
  /// 푸드모지 버튼 숨기기.
  private func dismissFoodmojiButton(_ notification: Notification) {
    UIView.animate(
      withDuration: FoodmojiAnimation.duration,
      delay: FoodmojiAnimation.delay,
      usingSpringWithDamping: FoodmojiAnimation.damping,
      initialSpringVelocity: FoodmojiAnimation.springVelocity,
      options: FoodmojiAnimation.animation,
      animations: { [weak self] in
        guard let self = self else { return }
        self.foodmojiButton.transform = .init(scaleX: 0.1, y: 0.1)
        self.foodmojiButton.alpha = 0
      },
      completion: nil
    )
    UIView.animate(
      withDuration: notification.keyboardDuration,
      delay: 0,
      options: notification.keyboardAnimation,
      animations: { [weak self] in
        guard let self = self else { return }
        self.foodmojiButton.center
          = .init(x: self.view.bounds.width / 2, y: self.view.bounds.height)
      },
      completion: { [weak self] _ in
        guard let self = self else { return }
        self.foodmojiButton.removeFromSuperview()
      }
    )
  }
  
  /// 상단 뷰 키보드 나타남에 대응
  private func adjustUpperViewIfKeyboardWillShow(_ notification: Notification) {
    UIView.animate(
      withDuration: notification.keyboardDuration,
      delay: 0,
      options: notification.keyboardAnimation,
      animations: { [weak self] in
        guard let self = self else { return }
        self.upperViewHeightConstraint
          = self.upperViewHeightConstraint.changedMultiplier(to: 0.4)
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  /// 상단 뷰 키보드 사라짐에 대응
  private func adjustUpperViewIfKeyboardWillHide(_ notification: Notification) {
    UIView.animate(
      withDuration: notification.keyboardDuration,
      delay: 0,
      options: notification.keyboardAnimation,
      animations: { [weak self] in
        guard let self = self else { return }
        self.upperViewHeightConstraint
          = self.upperViewHeightConstraint.changedMultiplier(to: 0.6)
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
}

// MARK: - KeyboardObserver 구현

extension MainViewController: KeyboardObserverProtocol {
  func keyboardWillShow(_ notification: Notification) {
    subscribeKeyboardWillShow(notification)
  }
  
  func keyboardWillHide(_ notification: Notification) {
    subscribeKeyboardWillHide(notification)
  }
  
  func keyboardDidShow(_ notification: Notification) {
    subscribeKeyboardDidShow(notification)
  }
}

// MARK: - KeyboardSubscriber 구현

extension MainViewController: KeyboardSubscriberProtocol {
  func subscribeKeyboardWillShow(_ notification: Notification) {
    adjustUpperViewIfKeyboardWillShow(notification)
  }
  
  func subscribeKeyboardWillHide(_ notification: Notification) {
    adjustUpperViewIfKeyboardWillHide(notification)
    dismissFoodmojiButton(notification)
  }
  
  func subscribeKeyboardDidShow(_ notification: Notification) {
    revealFoodmojiButton(notification)
  }
}

// MARK: - AddTasteButtonProtocol 구현

extension MainViewController: AddTasteButtonProtocol {
  
  var addTasteButtonAction: Selector? {
    return #selector(addTasteButtonDidTap(_:))
  }
  
  @objc func addTasteButtonDidTap(_ sender: UIBarButtonItem) {
    presentPopupViewController(foodName: foodName)
  }
}

// MARK: - PopupViewDelegate 구현

extension MainViewController: PopupViewDelegate {
  
  var foodName: String? {
    return nil
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
    textField.resignFirstResponder()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // 초기 상태로 돌아가기
    textField.text = nil
    textField.resignFirstResponder()
    return true
  }
}
