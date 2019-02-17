//
//  MockNetworkManager.swift
//  YelloSakedongTests
//
//  Created by Presto on 17/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

@testable import YelloSakedong
import Foundation
import Alamofire
import SwiftyJSON

class MockNetworkManager: NetworkManagerType {
  
  var json: JSON?
  
  var statusCode: StatusCode?
  
  var error: Error?
  
  func request(_ urlString: String, method: HTTPMethod, parameters: [String : Any], headers: [String : String], completion: @escaping (JSON?, StatusCode?, Error?) -> Void) {
    completion(json, statusCode, error)
  }
  
  func upload(_ urlString: String, parameters: [String : Any], headers: [String : String], completion: @escaping (JSON?, StatusCode?, Error?) -> Void) {
    completion(json, statusCode, error)
  }
}
