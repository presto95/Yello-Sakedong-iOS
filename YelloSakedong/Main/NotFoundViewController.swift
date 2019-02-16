//
//  NotFoundViewController.swift
//  YelloSakedong
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// 404 뷰 컨트롤러.
final class NotFoundViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    attachAddTasteButtonToNavigationBar()
  }
}

// MARK: - AddTasteButtonProtocol 구현

extension NotFoundViewController: AddTasteButtonProtocol {
  
  var addTasteButtonAction: Selector? {
    return #selector(addTasteButtonDidTap(_:))
  }
  
  @objc func addTasteButtonDidTap(_ sender: UIBarButtonItem) {
    presentPopupViewController(foodName: foodName)
  }
}

// MARK: - PopupViewDelegate 구현

extension NotFoundViewController: PopupViewDelegate {
  
  var foodName: String? {
    return nil
  }
}
