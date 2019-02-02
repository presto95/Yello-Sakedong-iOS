//
//  ProgressViewController.swift
//  YelloSakedong
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// 프로그레스 뜨는 뷰 컨트롤러.
final class ProgressViewController: UIViewController {
  
  // MARK: IBOutlet
  
  /// 푸드모지 이미지 뷰
  @IBOutlet private weak var foodmojiImageView: UIImageView!
  
  /// 프로그레스 뜨는 스택 뷰.
  @IBOutlet private weak var progressStackView: UIStackView! {
    didSet {
      progressStackView.arrangedSubviews.forEach {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.bounds.height / 2
      }
    }
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // count가 100이 되면 프로그레스 종료되게 해둠
    // 실제로는 여기서 API 호출을 해야 함
    var count = 0
    let timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { [weak self] timer in
      guard let self = self else { return }
      count += 1
      self.setFoodmojiImageView(at: count % 10)
      self.highlightCircle(at: count % 3)
      if count == 10 {
        if let parent = self.presentingViewController as? UINavigationController {
          // 결과를 찾으면 ResultViewController로
          // 그렇지 않으면 NotFoundViewController로 이동
          self.dismiss(animated: true) {
            StoryboardScene.Result.resultViewController
              .instantiate()
              .push(at: parent)
          }
          timer.invalidate()
        }
      }
    }
    timer.fire()
  }
  
  /// 프로그레스 스택뷰 안에 있는 원 색칠하여 프로그레스 느낌 주기
  private func highlightCircle(at index: Int) {
    progressStackView.arrangedSubviews.forEach { $0.backgroundColor = .white }
    progressStackView.arrangedSubviews[index].backgroundColor = .orange
  }
  
  /// 푸드모지 이미지 뷰 돌아가는 느낌 주기
  private func setFoodmojiImageView(at index: Int) {
    foodmojiImageView.image = Foodmoji.Medium.allCases[index].image
  }
}
