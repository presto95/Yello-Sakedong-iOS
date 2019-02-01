//
//  ProgressViewController.swift
//  YelloSakedong
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

final class ProgressViewController: UIViewController {
  
  @IBOutlet private weak var foodmojiImageView: UIImageView!
  
  @IBOutlet private weak var progressStackView: UIStackView! {
    didSet {
      progressStackView.arrangedSubviews.forEach {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.bounds.height / 2
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    var count = 0
    let timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] timer in
      guard let self = self else { return }
      count += 1
      self.highlightCircle(at: count % 3)
      if count == 100 {
        self.dismiss(animated: true, completion: nil)
        timer.invalidate()
      }
    }
    timer.fire()
  }
  
  private func highlightCircle(at index: Int) {
    progressStackView.arrangedSubviews.forEach { $0.backgroundColor = .white }
    progressStackView.arrangedSubviews[index].backgroundColor = .orange
  }
}
