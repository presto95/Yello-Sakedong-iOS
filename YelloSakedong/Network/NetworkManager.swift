//
//  NetworkManager.swift
//  YelloSakedong
//
//  Created by Presto on 16/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

/// 네트워크 매니저 프로토콜.
protocol NetworkManagerType: class {
  
  /// 네트워크 요청.
  ///
  /// - Parameters:
  ///   - urlString: URL 문자열.
  ///   - method: HTTP 메소드.
  ///   - parameters: 파라미터.
  ///   - headers: 헤더.
  ///   - completion: 컴플리션 핸들러.
  func request(_ urlString: String,
               method: HTTPMethod,
               parameters: [String: Any],
               headers: [String: String],
               completion: @escaping (JSON?, StatusCode?, Error?) -> Void)
  
  func upload(_ urlString: String,
              parameters: [String: Any],
              headers: [String: String],
              completion: @escaping (JSON?, StatusCode?, Error?) -> Void)
}

/// 네트워크 매니저.
final class NetworkManager: NetworkManagerType {
  
  /// Singleton Object.
  static let shared = NetworkManager()
  
  func request(_ urlString: String,
               method: HTTPMethod = .get,
               parameters: [String: Any] = [:],
               headers: [String: String] = [:],
               completion: @escaping (JSON?, StatusCode?, Error?) -> Void) {
    Alamofire
      .request(urlString,
               method: method,
               parameters: parameters,
               encoding: JSONEncoding.default,
               headers: headers)
      .responseJSON { response in
        let json = JSON(response)
        let statusCode = StatusCode(rawValue: response.response?.statusCode ?? 9999) ?? .default
        let error = response.error
        completion(json, statusCode, error)
    }
  }
  
  func upload(_ urlString: String,
              parameters: [String: Any],
              headers: [String: String],
              completion: @escaping (JSON?, StatusCode?, Error?) -> Void) {
    Alamofire
      .upload(
        multipartFormData: { multipartFormData in
          for (key, value) in parameters {
            if let imageData = value as? Data {
              multipartFormData.append(imageData, withName: key)
            } else {
              guard let value = "\(value)".data(using: .utf8) else {
                completion(nil, nil, NSError(domain: "", code: 0, userInfo: nil))
                return
              }
              multipartFormData.append(value, withName: key)
            }
          }
      },
        to: urlString,
        encodingCompletion: { result in
          switch result {
          case let .success(request, _, _):
            request.responseJSON { response in
              let json = JSON(response)
              let statusCode
                = StatusCode(rawValue: response.response?.statusCode ?? 9999) ?? .default
              let error = response.error
              completion(json, statusCode, error)
            }
          case let .failure(error):
            completion(nil, nil, error)
          }
      }
    )
  }
}
