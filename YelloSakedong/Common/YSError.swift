//
//  YSError.swift
//  YelloSakedong
//
//  Created by Presto on 16/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// 노랑사케동 커스텀 에러 프로토콜.
protocol YSError: Error { }

// MARK: YSError 프로토콜 초기 구현

extension YSError {
  
  var localizedDescription: String {
    if let error = self as? HTTPError {
      return error.localizedDescription
    }
    return ""
  }
}
