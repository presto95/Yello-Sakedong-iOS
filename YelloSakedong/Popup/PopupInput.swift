//
//  AddTasteData.swift
//  YelloSakedong
//
//  Created by Presto on 17/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

struct PopupInput: Codable {
  
  let foodName: String
  let foodImageURL: Data
  let foodComment: String
  let foodmojiIndex: Int
  
  enum CodingKeys: String, CodingKey {
    case foodName
    case foodImageURL = "foodImageUrl"
    case foodComment
    case foodmojiIndex = "foodEmoji"
  }
}
