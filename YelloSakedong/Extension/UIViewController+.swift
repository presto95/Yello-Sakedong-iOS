//
//  UIViewController+.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

extension UIViewController {

  func present(
    to viewController: UIViewController,
    transitionStyle style: UIModalTransitionStyle = .crossDissolve,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    modalTransitionStyle = style
    viewController.present(self, animated: animated, completion: completion)
  }
  
  func push(at navigationController: UINavigationController?, animated: Bool = true) {
    navigationController?.pushViewController(self, animated: animated)
  }
}
