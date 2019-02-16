//
//  RestError.swift
//  YelloSakedong
//
//  Created by Presto on 16/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// 나머지 커스텀 에러.
enum RestError: YSError {
  
  case `default`(String)
}

// MARK: RestError 프로토콜 초기 구현

extension RestError {
  
  var localizedDescription: String {
    switch self {
    case let .default(description):
      return description
    }
  }
}
