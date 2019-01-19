//
//  MainSearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var upperShadowView: UIView! {
        didSet {
            upperShadowView.hero.id = "upperView"
            upperShadowView.hero.modifiers = [.arc]
        }
    }
    
    @IBOutlet private weak var upperView: UIView! {
        didSet {
            upperView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchUpUpperView(_:))))
            upperView.hero.id = "upperView"
            upperView.hero.modifiers = [.arc]
            addArc()
        }
    }
    
    @IBOutlet private weak var lowerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        navigationController?.hero.navigationAnimationType = .fade
        navigationItem.rightBarButtonItem = addTasteButton
        navigationItem.backBarButtonItem = UIBarButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isBeingPresented || isMovingToParent {
            addArc()
        }
    }
    
    @objc private func touchUpUpperView(_ recognizer: UITapGestureRecognizer) {
        UIViewController
            .create(fromStoryboard: "Search", identifier: "SearchViewController")
            .push(at: navigationController)
    }
}

extension MainViewController: AddTasteButtonEnable {
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

private extension MainViewController {
    func addArc() {
        let path = UIBezierPath(arcCenter: .init(x: upperView.bounds.width / 2, y: 0), radius: upperView.bounds.height, startAngle: 0, endAngle: .pi, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        upperView.layer.mask = shapeLayer
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = path.cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 16, blur: 32, spread: 0)
        upperShadowView.layer.addSublayer(shadowLayer)
    }
}
