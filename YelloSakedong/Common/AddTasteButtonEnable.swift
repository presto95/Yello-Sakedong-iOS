//
//  AddTaste.swift
//  YelloSakedong
//
//  Created by Presto on 16/01/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import UIKit

protocol AddTasteButtonEnable: class {
    
    var addTasteButton: UIBarButtonItem { get }
    
    var tasteButtonTarget: AddTasteButtonEnable { get }
    
    var tasteButtonAction: Selector { get }
    
    func touchUpTasteButton(_ sender: UIBarButtonItem)
}

extension AddTasteButtonEnable {
    var addTasteButton: UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "add_taste"), style: .plain, target: tasteButtonTarget, action: tasteButtonAction)
    }
}
