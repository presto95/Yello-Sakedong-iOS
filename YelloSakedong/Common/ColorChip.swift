//
//  ChipColor.swift
//  YelloSakedong
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// 칩 색상 정의.
enum ColorChip: CaseIterable {
  
  case black
  
  case blue
  
  case green
  
  case orange
  
  case pink
  
  case purple
  
  case red
  
  case yellow
  
  /// 케이스에 따른 색상 뽑아내기.
  var color: AssetColorTypeAlias {
    switch self {
    case .black:
      return Asset.black.color
    case .blue:
      return Asset.blue.color
    case .green:
      return Asset.green.color
    case .orange:
      return Asset.orange.color
    case .pink:
      return Asset.pink.color
    case .purple:
      return Asset.purple.color
    case .red:
      return Asset.red.color
    case .yellow:
      return Asset.yellow.color
    }
  }
  
  /// 칩 색상 개수.
  static var count: Int {
    return ColorChip.allCases.count
  }
  
  /// 인덱스에 따른 색상 뽑아내기.
  static func color(at index: Int) -> AssetColorTypeAlias {
    return ColorChip.allCases[index].color
  }
}
