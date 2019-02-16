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

protocol NetworkManagerType: class {
  func request(_ urlString: String,
               method: HTTPMethod,
               parameters: [String: Any],
               headers: [String: String],
               completion: @escaping (JSON?, Int?, Error?) -> Void)
}

final class NetworkManager: NetworkManagerType {
  
  static let shared = NetworkManager()
  
  func request(_ urlString: String,
               method: HTTPMethod = .get,
               parameters: [String: Any] = [:],
               headers: [String: String] = [:],
               completion: @escaping (JSON?, Int?, Error?) -> Void) {
    Alamofire
      .request(urlString,
               method: method,
               parameters: parameters,
               encoding: JSONEncoding.default,
               headers: headers)
      .responseJSON { response in
        let json = JSON(response)
        let statusCode = response.response?.statusCode
        let error = response.error
        completion(json, statusCode, error)
    }
  }
}
