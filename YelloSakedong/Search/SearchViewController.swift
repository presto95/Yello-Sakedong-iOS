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
    
    private var keyboardFrame: CGRect!
    
    private var keyboardDuration: Double!
    
    private var keyboardAnimation: UIView.AnimationOptions!
    
    private var emoticonButton: UIButton! {
        didSet {
            emoticonButton.alpha = 0
            emoticonButton.setImage(UIImage(named: "sample"), for: [])
            emoticonButton.imageView?.contentMode = .scaleAspectFit
            emoticonButton.sizeToFit()
            emoticonButton.hero.id = "emoticonButton"
            emoticonButton.addTarget(self, action: #selector(touchUpEmoticonButton(_:)), for: .touchUpInside)
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
            tableView.register(UINib(nibName: "TranslationCell", bundle: nil), forCellReuseIdentifier: "translationCell")
        }
    }
    
    @IBOutlet private weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        navigationItem.rightBarButtonItem = addTasteButton
        emoticonButton = UIButton(type: .system)
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(named: "ic_back")
        navigationItem.backBarButtonItem = backButton
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchTextField.resignFirstResponder()
        UIView.animate(withDuration: keyboardDuration, delay: 0, options: keyboardAnimation, animations: { [weak self] in
            guard let `self` = self else { return }
            self.tableViewBottomConstraint.constant -= self.keyboardFrame.height
        }, completion: nil)
        view.layoutIfNeeded()
    }

    @objc private func touchUpEmoticonButton(_ sender: UIButton) {
        UIViewController
            .create(fromStoryboard: "Result", identifier: "ResultViewController")
            .push(at: navigationController)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let durationInfo = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        guard let curveInfo = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        let duration = durationInfo.doubleValue
        let curve = UIView.AnimationOptions(rawValue: UInt(truncating: curveInfo))
        self.keyboardFrame = keyboardFrame
        self.keyboardDuration = duration
        self.keyboardAnimation = curve
        UIView.animate(withDuration: duration, delay: 0, options: curve, animations: {
            self.tableViewBottomConstraint.constant += keyboardFrame.height
        }, completion: nil)
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(_ notificaton: Notification) {
        UIView.animate(withDuration: keyboardDuration, delay: 0, options: keyboardAnimation, animations: { [weak self] in
            guard let `self` = self else { return }
            self.tableViewBottomConstraint.constant -= self.keyboardFrame.height
            }, completion: nil)
        view.layoutIfNeeded()
    }
    
    private func revealEmoticonToKeyboard() {
        let centerPoint = CGPoint(x: view.bounds.width / 2, y: keyboardFrame.origin.y)
        emoticonButton.center = .init(x: centerPoint.x, y: centerPoint.y - 20)
        print(emoticonButton.frame)
        view.addSubview(emoticonButton)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.emoticonButton.alpha = 1
        }, completion: nil)
        view.layoutIfNeeded()
    }
    
    private func dismissEmoticon() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.emoticonButton.alpha = 0
        }, completion: nil)
        view.layoutIfNeeded()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        revealEmoticonToKeyboard()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
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
