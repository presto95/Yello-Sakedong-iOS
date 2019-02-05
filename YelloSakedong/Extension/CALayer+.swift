//
//  CALayer+.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
  
  func applyGradient(
    colors: [Any],
    locations: [NSNumber],
    startPoint: CGPoint = .init(x: 0.5, y: 0),
    endPoint: CGPoint = .init(x: 0.5, y: 1)
  ) {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    gradient.colors = colors
    gradient.locations = locations
    mask = gradient
  }
}
