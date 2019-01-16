//
//  MainSearchViewController.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit
import Hero

class MainViewController: UIViewController {

    @IBOutlet private weak var upperView: UIView! {
        didSet {
            upperView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchUpUpperView(_:))))
            upperView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 4, blur: 32, spread: 0)
            upperView.hero.id = "upperView"
            upperView.hero.modifiers = [.arc]
            addArc()
        }
    }
    
    @IBOutlet private weak var lowerView: UIView!

    @IBOutlet private weak var addTasteButton: UIButton! {
        didSet {
            addTasteButton.addTarget(self, action: #selector(touchUpAddTasteButton(_:)), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        hero.modalAnimationType = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addArc()
    }
    
    @objc private func touchUpUpperView(_ recognizer: UITapGestureRecognizer) {
        UIViewController
            .create(fromStoryboard: "Search", identifier: "SearchViewController")
            .present(to: self, transitionStyle: .crossDissolve, animated: true, completion: nil)
    }
    
    @objc private func touchUpAddTasteButton(_ sender: UIButton) {
        
    }
}

private extension MainViewController {
    func addArc() {
        let path = UIBezierPath(arcCenter: .init(x: upperView.bounds.width / 2, y: 0), radius: upperView.bounds.height, startAngle: 0, endAngle: .pi, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        upperView.layer.mask = shapeLayer
    }
}
