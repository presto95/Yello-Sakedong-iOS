//
//  ResultViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView! {
    didSet {
      tableView.hero.modifiers = [.cascade]
      tableView.register(
        UINib(nibName: "ResultInfoCell", bundle: nil),
        forCellReuseIdentifier: "infoCell"
      )
      tableView.register(
        UINib(nibName: "TranslationCell", bundle: nil),
        forCellReuseIdentifier: "translationCell"
      )
      tableView.rowHeight = UITableView.automaticDimension
      tableView.delegate = self
      tableView.dataSource = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hero.isEnabled = true
    navigationItem.rightBarButtonItem = addTasteButton
    navigationItem.backBarButtonItem = UIBarButtonItem()
  }
}

extension ResultViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let section = indexPath.section
    if section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
      cell.hero.modifiers = [.fade]
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "translationCell", for: indexPath)
      if section == 1 {
        cell.backgroundColor = UIColor(red: 255, green: 203, blue: 0)
      } else if section == 2 {
        cell.backgroundColor = UIColor(red: 248, green: 249, blue: 251)
      }
      if let translationCell = cell as? TranslationCell {
        if section == 2 {
          translationCell.setColorLabelWidth(10)
        } else {
          translationCell.setColorLabelWidth(0)
        }
      }
      cell.hero.modifiers = [.fade, .scale(0.5)]
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

extension ResultViewController: UITableViewDelegate {
  
}

extension ResultViewController: AddTasteButtonEnable {
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
