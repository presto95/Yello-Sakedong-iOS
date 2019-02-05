//
//  PopupViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

import FSPagerView
import Hero

/// 팝업 뷰 컨트롤러.
final class PopupViewController: UIViewController {
  
  /// 페이지 컨트롤의 현재 인덱스.
  var currentPageControlIndex: Int {
    get {
      return pageControl.currentPage
    }
    set {
      pageControl.currentPage = newValue
    }
  }
  
  /// 키보드가 나타나 있는가.
  private var isKeyboardAppeared: Bool = false
  
  /// 페이저 뷰의 선택된 인덱스.
  private var selectedIndexOfPagerView: Int?
  
  /// 페이저 셀 내 스택 뷰의 선택된 인덱스.
  private var selectedIndexInPagerCell: Int?
  
  /// 페이저 뷰가 선택되었는지.
  private var hasPagerViewSelected: Bool {
    return selectedIndexOfPagerView != nil && selectedIndexInPagerCell != nil
  }
  
  // MARK: - IBOutlet
  
  /// 팝업 배경 컨테이너 뷰.
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
      backgroundView.layer.cornerRadius = 6
    }
  }
  
  /// 이미지 추가 버튼.
  @IBOutlet private weak var addImageButton: UIButton! {
    didSet {
      addImageButton.clipsToBounds = true
      addImageButton.layer.cornerRadius = addImageButton.bounds.height / 2
      addImageButton.setBackgroundImage(Asset.addImage.image, for: [])
      addImageButton.imageView?.contentMode = .scaleAspectFit
      addImageButton.addTarget(self, action: #selector(addButtonDidTap(_:)), for: .touchUpInside)
    }
  }
  
  /// 맛 등록 버튼.
  @IBOutlet private weak var registerButton: UIButton! {
    didSet {
      registerButton.isEnabled = false
      let path = UIBezierPath(
        roundedRect: registerButton.bounds,
        byRoundingCorners: [.bottomLeft, .bottomRight],
        cornerRadii: .init(width: 6, height: 0)
      )
      let shapeLayer = CAShapeLayer()
      shapeLayer.path = path.cgPath
      registerButton.layer.mask = shapeLayer
      registerButton.addTarget(
        self,
        action: #selector(registerButtonDidTap(_:)),
        for: .touchUpInside
      )
    }
  }
  
  /// 취소 버튼.
  @IBOutlet private weak var cancelButton: UIButton! {
    didSet {
      cancelButton.addTarget(
        self,
        action: #selector(cancelButtonDidTap(_:)),
        for: .touchUpInside
      )
    }
  }
  
  /// 맛 디스크립션 입력받는 텍스트 뷰.
  @IBOutlet private weak var textView: UITextView!
  
  /// 푸드모지 페이저 뷰.
  @IBOutlet private weak var pagerView: PopupFoodmojiPagerView! {
    didSet {
      pagerView.delegate = self
      pagerView.dataSource = self
    }
  }
  
  /// 푸드모지 페이저 뷰 좌측 페이드 효과를 위한 뷰.
  @IBOutlet private weak var pagerViewLeadingGradientView: UIView! {
    didSet {
      pagerViewLeadingGradientView.layer.applyGradient(
        colors: [UIColor.white.cgColor, UIColor.clear.cgColor],
        locations: [0, 1],
        startPoint: .init(x: 0, y: 0.5),
        endPoint: .init(x: 1, y: 0.5)
      )
    }
  }
  
  /// 푸드모지 페이저 뷰 우측 페이드 효과를 위한 뷰.
  @IBOutlet private weak var pagerViewTrailingGradientView: UIView! {
    didSet {
      pagerViewTrailingGradientView.layer.applyGradient(
        colors: [UIColor.clear.cgColor, UIColor.white.cgColor],
        locations: [0, 1],
        startPoint: .init(x: 0, y: 0.5),
        endPoint: .init(x: 1, y: 0.5)
      )
    }
  }
  
  /// 푸드모지 페이지 컨트롤.
  @IBOutlet private weak var pageControl: FSPageControl! {
    didSet {
      pageControl.currentPage = 0
      pageControl.numberOfPages = Foodmoji.Small.Colored.allCases.count / 5
      pageControl.itemSpacing = 7
      pageControl.setFillColor(UIColor(rgb: 216), for: .normal)
      pageControl.setFillColor(UIColor(rgb: 119), for: .selected)
      pageControl.setStrokeColor(nil, for: [])
      pageControl.contentInsets = .init(top: 0, left: 0, bottom: 8, right: 0)
    }
  }
  
  /// 배경 컨테이너 뷰 센터 Y 제약.
  @IBOutlet private weak var backgroundViewCenterYConstraint: NSLayoutConstraint!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerKeyboardNotifications()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    textView.becomeFirstResponder()
  }
  
  deinit {
    removeKeyboardNotifications()
  }
  
  // MARK: - @objc Method

  /// 이미지 추가 버튼 눌렀을 때의 동작.
  @objc private func addButtonDidTap(_ sender: UIButton) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .photoLibrary
      imagePicker.allowsEditing = true
      present(imagePicker, animated: true, completion: nil)
    }
  }
  
  /// 맛 등록 버튼 눌렀을 때의 동작.
  @objc private func registerButtonDidTap(_ sender: UIButton) {
    // 맛 추가
    hero.dismissViewController()
  }
  
  /// 취소 버튼 눌렀을 때의 동작.
  @objc private func cancelButtonDidTap(_ sender: UIButton) {
    hero.dismissViewController()
  }
  
  // MARK: - Private Method
  
  /// 키보드가 나타날 때 팝업 뷰를 키보드에 대응하기.
  private func adjustPopupViewIfKeyboardWillShow(_ notification: Notification) {
    UIView.animate(
      withDuration: notification.keyboardDuration,
      delay: 0,
      options: notification.keyboardAnimation,
      animations: { [weak self] in
        guard let self = self else { return }
        if !self.isKeyboardAppeared {
          self.backgroundViewCenterYConstraint.constant -= notification.keyboardFrame.height / 2.5
          self.isKeyboardAppeared = !self.isKeyboardAppeared
        }
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  /// 키보드가 사라질 때 팝업 뷰를 키보드에 대응하기.
  private func adjustPopupViewIfKeyboardWillHide(_ notification: Notification) {
    UIView.animate(
      withDuration: notification.keyboardDuration,
      delay: 0,
      options: notification.keyboardAnimation,
      animations: { [weak self] in
        guard let self = self else { return }
        if self.isKeyboardAppeared {
          self.backgroundViewCenterYConstraint.constant += notification.keyboardFrame.height / 2.5
          self.isKeyboardAppeared = !self.isKeyboardAppeared
        }
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
}

// MARK: - KeyboardObserver 구현

extension PopupViewController: KeyboardObserver {
  func keyboardWillShow(_ notification: Notification) {
    subscribeKeyboardWillShow(notification)
  }
  
  func keyboardWillHide(_ notification: Notification) {
    subscribeKeyboardWillHide(notification)
  }
}

// MARK: - KeyboardSubscriber 구현

extension PopupViewController: KeyboardSubscriber {
  func subscribeKeyboardWillShow(_ notification: Notification) {
    adjustPopupViewIfKeyboardWillShow(notification)
  }
  
  func subscribeKeyboardWillHide(_ notification: Notification) {
    adjustPopupViewIfKeyboardWillHide(notification)
  }
}

// MARK: - FSPagerViewDataSource 구현

extension PopupViewController: FSPagerViewDataSource {
  func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
    let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
    if let popupCell = cell as? PopupFoodmojiPagerCell {
      popupCell.delegate = self
      popupCell.cellIndex = index
      popupCell.setFoodmojiButtons(
        selectedIndexOfPagerView: selectedIndexOfPagerView,
        selectedIndexInPagerCell: selectedIndexInPagerCell
      )
    }
    return cell
  }
  
  func numberOfItems(in pagerView: FSPagerView) -> Int {
    return Foodmoji.Small.Colored.allCases.count / 5
  }
}

// MARK: - FSPagerViewDelegate 구현

extension PopupViewController: FSPagerViewDelegate {
  func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
    currentPageControlIndex = targetIndex
  }
}

// MARK: - PopupFoodmojiPagerCellDelegate 구현

extension PopupViewController: PopupFoodmojiPagerCellDelegate {
  func popupFoodmojiPagerCell(
    _ popupFoodmojiPagerCell: PopupFoodmojiPagerCell,
    didTapFoodmojiButton button: UIButton,
    in pagerCellIndex: Int,
    at buttonIndex: Int
  ) {
    selectedIndexOfPagerView = pagerCellIndex
    selectedIndexInPagerCell = buttonIndex
    pagerView.reloadData()
  }
}

// MARK: - UIImagePickerControllerDelegate 구현

extension PopupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    if let image = info[.editedImage] as? UIImage {
      addImageButton.setBackgroundImage(image, for: [])
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
