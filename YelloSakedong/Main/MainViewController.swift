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
  
  private var keyboardInfo: KeyboardInfo!
  
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
    StoryboardScene.Main.progressViewController
      .instantiate()
      .present(to: self)
  }
  
  @objc private func upperViewDidTap(_ recognizer: UITapGestureRecognizer) {
    foodTextField.becomeFirstResponder()
  }
  
  @objc private func foodTextFieldTextDidChange(_ textField: UITextField) {
    
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    
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

extension MainViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // 상단 뷰 약간 위로 올라가며 입력 받을 준비
   
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    // 초기 상태로 돌아가기
    textField.text = nil
  }
}

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
