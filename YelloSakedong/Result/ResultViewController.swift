//
//  ResultViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

/// 결과 뷰 컨트롤러.
final class ResultViewController: UIViewController {
  
  /// 셀 식별자 상수 정리.
  enum CellIdentifier {
    static let infoCell = "infoCell"
    static let translationCell = "translationCell"
  }
  
  // MARK: IBOutlet
  
  /// 결과 테이블 뷰.
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.hero.modifiers = [.cascade]
      tableView.register(
        UINib(nibName: ResultInfoCell.classNameToString, bundle: nil),
        forCellReuseIdentifier: CellIdentifier.infoCell
      )
      tableView.register(
        UINib(nibName: ResultTranslationCell.classNameToString, bundle: nil),
        forCellReuseIdentifier: CellIdentifier.translationCell
      )
      tableView.rowHeight = UITableView.automaticDimension
      tableView.dataSource = self
    }
  }
  
  // MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    navigationItem.rightBarButtonItem = addTasteButton
    navigationItem.backBarButtonItem = UIBarButtonItem()
  }
}

// MARK: - UITableViewDataSource 구현

extension ResultViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = indexPath.section
    if section == 0 {
      // 0번 섹션: 정보 셀
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.infoCell,
                                               for: indexPath)
      cell.hero.modifiers = [.fade]
      return cell
    } else {
      // 나머지 섹션: Translation 셀
      // 1번 섹션: 내가 등록한 것을 표시하는 셀
      // 2번 섹션: 다른 사람이 등록한 것 중 순위권에 있는 것을 표시하는 셀
      // 3번 섹션: 다른 사람이 등록한 것 중 순위권에 없는 것을 표시하는 셀
      let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.translationCell,
                                               for: indexPath)
      if let translationCell = cell as? ResultTranslationCell {
        translationCell.delegate = self
        if section == 1 {
          translationCell.hidesDeleteButton = false
          translationCell.hidesColorChipView = true
          translationCell.isRanked = false
          translationCell.backgroundColor = .myBackgroundColor
        } else if section == 2 {
          translationCell.hidesDeleteButton = true
          translationCell.hidesColorChipView = false
          translationCell.isRanked = true
          translationCell.backgroundColor = .rankedBackgroundColor
        } else {
          translationCell.hidesDeleteButton = true
          translationCell.hidesColorChipView = true
          translationCell.isRanked = false
        }
      }
      cell.hero.modifiers = [.fade, .scale(0.5)]
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // 정보에 따라 달라짐
    switch section {
    case 0:
      return 1
    case 1:
      return 1
    case 2:
      return 3
    case 3:
      return 1
    default:
      return 0
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
}

// MARK: - ResultTranslationCellDelegate 구현

extension ResultViewController: ResultTranslationCellDelegate {
  func resultTranslationCell(_ resultTranslationCell: ResultTranslationCell,
                             didTapDeleteButton button: UIButton) {
    UIAlertController
      .alert(title: "", message: "삭제할까요?")
      .action(title: "네", style: .destructive) { _, _ in
        // 삭제 버튼 눌렀을 때의 동작 정의
      }
      .action(title: "아니오", style: .cancel, handler: nil)
      .present(to: self)
  }
}

// MARK: - AddTasteButtonProtocol 구현

extension ResultViewController: AddTasteButtonProtocol {
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
