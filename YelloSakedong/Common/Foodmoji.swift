//
//  Foodicon.swift
//  YelloSakedong
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

enum Foodmoji: CaseIterable {
  
  enum Large: CaseIterable {
    
    case first
    
    case second
    
    case third
    
    case fourth
    
    case fifth
    
    case sixth
    
    case seventh
    
    case eighth
    
    case ninth
    
    case tenth
    
    var image: AssetImageTypeAlias? {
      switch self {
      case .first:
        return Asset.emoL1.image
      case .second:
        return Asset.emoL2.image
      case .third:
        return Asset.emoL3.image
      case .fourth:
        return Asset.emoL4.image
      case .fifth:
        return Asset.emoL5.image
      case .sixth:
        return Asset.emoL6.image
      case .seventh:
        return Asset.emoL7.image
      case .eighth:
        return Asset.emoL8.image
      case .ninth:
        return Asset.emoL9.image
      case .tenth:
        return Asset.emoL10.image
      }
    }
    
    static var count: Int {
      return Foodmoji.Large.allCases.count
    }
    
    static func image(at index: Int) -> AssetImageTypeAlias? {
      return Foodmoji.Large.allCases[index].image
    }
  }
  
  enum Medium: CaseIterable {
    
    case first
    
    case second
    
    case third
    
    case fourth
    
    case fifth
    
    case sixth
    
    case seventh
    
    case eighth
    
    case ninth
    
    case tenth
    
    var image: AssetImageTypeAlias? {
      switch self {
      case .first:
        return Asset.emoM1.image
      case .second:
        return Asset.emoM2.image
      case .third:
        return Asset.emoM3.image
      case .fourth:
        return Asset.emoM4.image
      case .fifth:
        return Asset.emoM5.image
      case .sixth:
        return Asset.emoM6.image
      case .seventh:
        return Asset.emoM7.image
      case .eighth:
        return Asset.emoM8.image
      case .ninth:
        return Asset.emoM9.image
      case .tenth:
        return Asset.emoM10.image
      }
    }
    
    static var count: Int {
      return Foodmoji.Medium.allCases.count
    }
    
    static func image(at index: Int) -> AssetImageTypeAlias? {
      return Foodmoji.Medium.allCases[index].image

    }
  }
  
  enum Small: CaseIterable {
    
    enum Colored: CaseIterable {
      
      case first
      
      case second
      
      case third
      
      case fourth
      
      case fifth
      
      case sixth
      
      case seventh
      
      case eighth
      
      case ninth
      
      case tenth
      
      var image: AssetImageTypeAlias? {
        switch self {
        case .first:
          return Asset.emoS1.image
        case .second:
          return Asset.emoS2.image
        case .third:
          return Asset.emoS3.image
        case .fourth:
          return Asset.emoS4.image
        case .fifth:
          return Asset.emoS5.image
        case .sixth:
          return Asset.emoS6.image
        case .seventh:
          return Asset.emoS7.image
        case .eighth:
          return Asset.emoS8.image
        case .ninth:
          return Asset.emoS9.image
        case .tenth:
          return Asset.emoS10.image
        }
      }
      
      static var count: Int {
        return Foodmoji.Small.Colored.allCases.count
      }
      
      static func image(at index: Int) -> AssetImageTypeAlias? {
        return Foodmoji.Small.Colored.allCases[index].image
      }
    }
    
    enum Uncolored: CaseIterable {
      
      case first
      
      case second
      
      case third
      
      case fourth
      
      case fifth
      
      case sixth
      
      case seventh
      
      case eighth
      
      case ninth
      
      case tenth
      
      var image: AssetImageTypeAlias? {
        switch self {
        case .first:
          return Asset.emoSGrey1.image
        case .second:
          return Asset.emoSGrey2.image
        case .third:
          return Asset.emoSGrey3.image
        case .fourth:
          return Asset.emoSGrey4.image
        case .fifth:
          return Asset.emoSGrey5.image
        case .sixth:
          return Asset.emoSGrey6.image
        case .seventh:
          return Asset.emoSGrey7.image
        case .eighth:
          return Asset.emoSGrey8.image
        case .ninth:
          return Asset.emoSGrey9.image
        case .tenth:
          return Asset.emoSGrey10.image
        }
      }
      
      static var count: Int {
        return Foodmoji.Small.Uncolored.allCases.count
      }
      
      static func image(at index: Int) -> AssetImageTypeAlias? {
        return Foodmoji.Small.Uncolored.allCases[index].image
      }
    }
  }
}
