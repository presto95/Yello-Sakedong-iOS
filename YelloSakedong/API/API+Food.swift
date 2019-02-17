//
//  API+Food.swift
//  YelloSakedong
//
//  Created by Presto on 17/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

/// Food 관련 API 프로토콜.
protocol APIFoodType: APIType {
  
  /// 맛 추가.
  ///
  /// - Parameters:
  ///   - parameters: 파라미터.
  ///   - completion: 컴플리션 핸들러.
  func addFood(_ popupInput: PopupInput, completion: @escaping (YSError?) -> Void)
}

/// Food 관련 API.
final class APIFood: APIFoodType {
  
  var networkManager: NetworkManagerType
  
  var subURI: String {
    return "/food"
  }
  
  // MARK: Dependency Injection
  
  init(networkManager: NetworkManagerType = NetworkManager.shared) {
    self.networkManager = networkManager
  }
  
  func addFood(_ popupInput: PopupInput, completion: @escaping (YSError?) -> Void) {
    let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
    let headers = ["Content-Type": "multipart/form-data", "_id": userID]
    let parameters: [String: Any] = [
      "foodName": popupInput.foodName,
      "foodImageUrl": popupInput.foodImageURL,
      "foodComment": popupInput.foodComment,
      "foodEmoji": popupInput.foodmojiIndex
    ]
    networkManager.upload("\(baseURL)\(subURI)",
      parameters: parameters,
      headers: headers) { json, statusCode, error in
        if let error = error {
          completion(RestError.default(error.localizedDescription))
          return
        }
        guard json != nil, let statusCode = statusCode else { return }
        switch statusCode {
          // 성공하면 에러 없음
          // 그렇지 않으면 각 케이스에 해당하는 에러를 넘겨줌
        case .created:
          completion(nil)
        case .conflict:
          completion(HTTPError.conflict)
        case .internalServerError:
          completion(HTTPError.internalServerError)
        default:
          completion(HTTPError.default)
        }
    }
  }
}
