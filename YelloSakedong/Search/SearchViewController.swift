//
//  SearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import Hero
import DZNEmptyDataSet

class SearchViewController: UIViewController {
    
    private var keyboardFrame: CGRect!
    
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
            tableView.register(UINib(nibName: "TranslationCell", bundle: nil), forCellReuseIdentifier: "translationCell")
        }
    }
    
    @IBOutlet private weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        navigationItem.setRightBarButton(addTasteButton, animated: false)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let durationInfo = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curveInfo = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        let duration = durationInfo.doubleValue
        let curve = UIView.AnimationOptions(rawValue: UInt(truncating: curveInfo))
        self.keyboardFrame = keyboardFrame
        UIView.animate(withDuration: duration, delay: 0, options: curve, animations: {
            self.tableViewBottomConstraint.constant += keyboardFrame.height
        }, completion: nil)
        view.layoutIfNeeded()
    }
    
    private func revealEmoticonToKeyboard() {
        let centerPoint = CGPoint(x: view.bounds.width / 2, y: keyboardFrame.origin.y)
        let emoticonImageView = UIImageView(image: #imageLiteral(resourceName: "sample"))
        emoticonImageView.alpha = 0
        emoticonImageView.center = centerPoint
        view.addSubview(emoticonImageView)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            emoticonImageView.alpha = 1
        }, completion: nil)
        view.layoutIfNeeded()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
