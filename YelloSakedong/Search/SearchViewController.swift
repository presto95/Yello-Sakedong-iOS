//
//  SearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SearchViewController: UIViewController {
  
  private var keyboardInfo: KeyboardInfo!
  
  private var emoticonButton: UIButton! {
    didSet {
      emoticonButton.alpha = 0
      emoticonButton.setImage(UIImage(named: "sample"), for: [])
      emoticonButton.imageView?.contentMode = .scaleAspectFit
      emoticonButton.sizeToFit()
      let size = emoticonButton.bounds.size
      emoticonButton.bounds.size = .init(width: size.width - 20, height: size.height - 20)
      emoticonButton.hero.id = "emoticonButton"
      emoticonButton.addTarget(
        self,
        action: #selector(touchUpEmoticonButton(_:)),
        for: .touchUpInside
      )
    }
  }
  
  @IBOutlet private weak var upperView: UIView! {
    didSet {
      upperView.hero.id = "upperView"
      upperView.hero.modifiers = [.arc]
    }
  }
  
  @IBOutlet private weak var searchTextField: UITextField! {
    didSet {
      searchTextField.delegate = self
    }
  }
  
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.emptyDataSetSource = self
      tableView.separatorStyle = .none
      tableView.allowsSelection = false
      tableView.register(
        UINib(nibName: "TranslationCell", bundle: nil),
        forCellReuseIdentifier: "translationCell"
      )
    }
  }
  
  @IBOutlet private weak var tableViewBottomConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    navigationItem.rightBarButtonItem = addTasteButton
    emoticonButton = UIButton(type: .system)
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
    searchTextField.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    searchTextField.resignFirstResponder()
  }
  
  @objc private func touchUpEmoticonButton(_ sender: UIButton) {
    UIViewController
      .create(fromStoryboard: "Result", identifier: "ResultViewController")
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
        self.tableViewBottomConstraint.constant += self.keyboardInfo.frame.height
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
        self.tableViewBottomConstraint.constant -= self.keyboardInfo.frame.height
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  private func revealEmoticonBehindKeyboard() {
    let centerPoint = CGPoint(x: view.bounds.width / 2, y: keyboardInfo.frame.origin.y)
    emoticonButton.center = .init(x: centerPoint.x, y: centerPoint.y - 20)
    view.addSubview(emoticonButton)
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      options: .curveEaseInOut,
      animations: {
        self.emoticonButton.alpha = 1
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  private func dismissEmoticon() {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      options: .curveEaseInOut,
      animations: {
        self.emoticonButton.alpha = 0
      },
      completion: nil
    )
    view.layoutIfNeeded()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}

extension SearchViewController: UITextFieldDelegate {
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    revealEmoticonBehindKeyboard()
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
  }
}

extension SearchViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "translationCell", for: indexPath)
    cell.backgroundColor = UIColor(red: 248, green: 249, blue: 251)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
}

extension SearchViewController: UITableViewDelegate {
  
}

extension SearchViewController: AddTasteButtonEnable {
  var tasteButtonTarget: AddTasteButtonEnable {
    return self
  }
  
  var tasteButtonAction: Selector {
    return #selector(touchUpTasteButton(_:))
  }
  
  @objc func touchUpTasteButton(_ sender: UIBarButtonItem) {
    UIViewController
      .create(fromStoryboard: "Popup", identifier: "PopupViewController")
      .present(to: self, transitionStyle: .crossDissolve, animated: true, completion: nil)
  }
}

extension SearchViewController: DZNEmptyDataSetSource {
  func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
    return UIImage(named: "sample")
  }
}
