//
//  Foodicon.swift
//  YelloSakedong
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// 푸드모지 정의.
enum Foodmoji: CaseIterable {
  
  /// 큰 크기 푸드모지.
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
    
    /// 큰 크기 푸드모지 각 케이스에 해당하는 이미지.
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
    
    /// 큰 크기 푸드모지 개수.
    static var count: Int {
      return Foodmoji.Large.allCases.count
    }
    
    /// 큰 크기 푸드모지의 특정 인덱스 이미지 가져오기.
    static func image(at index: Int) -> AssetImageTypeAlias? {
      assert(index >= 0 && index < count,
             "Index must be greater than or equal to 0 and less than 10.")
      return Foodmoji.Large.allCases[index].image
    }
  }
  
  /// 중간 크기 푸드모지.
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
    
    /// 중간 크기 푸드모지 각 케이스에 해당하는 이미지.
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
    
    /// 중간 크기 푸드모지 개수.
    static var count: Int {
      return Foodmoji.Medium.allCases.count
    }
    
    /// 중간 크기 푸드모지의 특정 인덱스 이미지 가져오기.
    static func image(at index: Int) -> AssetImageTypeAlias? {
      assert(index >= 0 && index < count,
             "Index must be greater than or equal to 0 and less than 10.")
      return Foodmoji.Medium.allCases[index].image

    }
  }
  
  /// 작은 크기 푸드모지.
  enum Small: CaseIterable {
    
    /// 작은 크기 색깔 입혀진 푸드모지.
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
      
      /// 작은 색 있는 푸드모지 각 케이스에 해당하는 이미지.
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
      
      /// 작은 색 있는 푸드모지 개수.
      static var count: Int {
        return Foodmoji.Small.Colored.allCases.count
      }
      
      /// 작은 색 있는 푸드모지의 특정 인덱스 이미지 가져오기.
      static func image(at index: Int) -> AssetImageTypeAlias? {
        assert(index >= 0 && index < count,
               "Index must be greater than or equal to 0 and less than 10.")
        return Foodmoji.Small.Colored.allCases[index].image
      }
    }
    
    /// 작은 크기 색깔 없는 푸드모지.
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
      
      /// 작은 색 없는 푸드모지 각 케이스에 해당하는 이미지.
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
      
      /// 작은 색 없는 푸드모지 개수.
      static var count: Int {
        return Foodmoji.Small.Uncolored.allCases.count
      }
      
      /// 작은 색 없는 푸드모지의 특정 인덱스 이미지 가져오기.
      static func image(at index: Int) -> AssetImageTypeAlias? {
        assert(index >= 0 && index < count,
               "Index must be greater than or equal to 0 and less than 10.")
        return Foodmoji.Small.Uncolored.allCases[index].image
      }
    }
  }
}
