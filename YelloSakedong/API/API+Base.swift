//
//  API+Base.swift
//  YelloSakedong
//
//  Created by Presto on 16/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// API 프로토콜.
protocol APIType: class {
  
  /// Base URL.
  var baseURL: String { get }
  
  /// Sub URI.
  var subURI: String { get }
  
  /// 네트워크 매니저.
  var networkManager: NetworkManagerType { get }
}

// MARK: - APIType 프로토콜 초기 구현

extension APIType {
  
  var baseURL: String {
    return "http://localhost:3000"
  }
  
  var networkManager: NetworkManagerType {
    return NetworkManager.shared
  }
}
