//
//  TestAPIFood.swift
//  YelloSakedongTests
//
//  Created by Presto on 17/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

@testable import YelloSakedong
import Foundation
import XCTest
import SwiftyJSON

class TestAPIFood: XCTestCase {
  
  let mockNetworkManager = MockNetworkManager()
  var apiFood: APIFood!
  
  override func setUp() {
    apiFood = APIFood(networkManager: mockNetworkManager)
  }
}
