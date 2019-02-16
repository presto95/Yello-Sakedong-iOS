//
//  API+User.swift
//  YelloSakedong
//
//  Created by Presto on 16/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// User 관련 API 프로토콜.
protocol APIUserType: APIType {
  
  /// 회원 가입.
  ///
  /// - Parameters:
  ///   - key: 고유 키.
  ///   - completion: 컴플리션 핸들러.
  func signUp(key: String, completion: @escaping (String?, Error?) -> Void)
}

/// User 관련 API.
final class APIUser: APIUserType {
  
  var networkManager: NetworkManagerType
  
  var subURI: String {
    return "/user"
  }
  
  // MARK: Dependency Injection
  
  init(networkManager: NetworkManagerType = NetworkManager.shared) {
    self.networkManager = networkManager
  }
  
  func signUp(key: String, completion: @escaping (String?, Error?) -> Void) {
    let headers = ["Content-Type": "application/json", "yellowSakedongKey": key]
    networkManager
      .request("\(baseURL)\(subURI)/signup",
        method: .post,
        parameters: [:],
        headers: headers) { json, statusCode, error in
          if let error = error {
            completion(nil, error)
            return
          }
          guard let json = json, let statusCode = statusCode else { return }
          switch statusCode {
          case .created:
            let userID = json["userID"].stringValue
            completion(userID, nil)
          case .conflict:
            completion(nil, HTTPError.conflict)
          case .internalServerError:
            completion(nil, HTTPError.internalServerError)
          default:
            break
          }
    }
  }
}
