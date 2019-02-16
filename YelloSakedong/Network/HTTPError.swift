//
//  HTTPError.swift
//  YelloSakedong
//
//  Created by Presto on 16/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// HTTP 통신 에러 정의.
enum HTTPError: Error {
  
  /// 409
  case conflict

  /// 500
  case internalServerError
  
  /// 나머지
  case `default`
}

extension HTTPError {
  
  var localizedDescription: String {
    switch self {
    case .conflict:
      return "키 충돌"
    case .internalServerError:
      return "서버 에러"
    case .default:
      return "알 수 없는 에런"
    }
  }
}
