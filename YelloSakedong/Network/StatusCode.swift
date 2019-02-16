//
//  StatusCode.swift
//  YelloSakedong
//
//  Created by Presto on 16/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// HTTP 상태 코드 정의.
enum StatusCode: Int {
  
  /// 201 Created.
  case created = 201
  
  /// 409 Conflict.
  case conflict = 409
  
  /// 500 Internal Server Error.
  case internalServerError = 500
  
  /// 나머지.
  case `default` = 9999
}
