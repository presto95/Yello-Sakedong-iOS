//
//  TestAPIUser.swift
//  YelloSakedongTests
//
//  Created by Presto on 17/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

@testable import YelloSakedong
import Foundation
import XCTest
import SwiftyJSON

class TestAPIUser: XCTestCase {
  
  let mockNetworkManager = MockNetworkManager()
  var apiUser: APIUser!
  
  override func setUp() {
    apiUser = APIUser(networkManager: mockNetworkManager)
  }
  
  func test_signUp() {
    let expect = expectation(description: "test")
    mockNetworkManager.json = try! JSON(data: DummyAPIUser.responseCreated.data(using: .utf8)!)
    mockNetworkManager.statusCode = .created
    mockNetworkManager.error = nil
    apiUser.signUp(key: "") { userID, error in
      XCTAssertNotNil(userID)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func test_signUp_error_network() {
    let expect = expectation(description: "test")
    mockNetworkManager.json = nil
    mockNetworkManager.statusCode = .created
    mockNetworkManager.error = NSError(domain: "", code: 0, userInfo: nil)
    apiUser.signUp(key: "") { userID, error in
      XCTAssertNil(userID)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func test_signUp_error_conflict() {
    let expect = expectation(description: "test")
    mockNetworkManager.json = try! JSON(data: DummyAPIUser.responseConflict.data(using: .utf8)!)
    mockNetworkManager.statusCode = .conflict
    mockNetworkManager.error = nil
    apiUser.signUp(key: "") { userID, error in
      XCTAssertNil(userID)
      XCTAssertNotNil(error)
      if let error = error as? HTTPError {
        XCTAssertEqual(error, HTTPError.conflict)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func test_signUp_error_internalServerError() {
    let expect = expectation(description: "test")
    mockNetworkManager.json = try! JSON(data: DummyAPIUser.responseInternalServerError.data(using: .utf8)!)
    mockNetworkManager.statusCode = .internalServerError
    mockNetworkManager.error = nil
    apiUser.signUp(key: "") { userID, error in
      XCTAssertNil(userID)
      XCTAssertNotNil(error)
      if let error = error as? HTTPError {
        XCTAssertEqual(error, HTTPError.internalServerError)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
  }
  
  func test_signUp_error_default() {
    let expect = expectation(description: "test")
    mockNetworkManager.json = try! JSON(data: DummyAPIUser.responseInternalServerError.data(using: .utf8)!)
    mockNetworkManager.statusCode = .default
    mockNetworkManager.error = nil
    apiUser.signUp(key: "") { userID, error in
      XCTAssertNil(userID)
      XCTAssertNotNil(error)
      if let error = error as? HTTPError {
        XCTAssertEqual(error, HTTPError.default)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1, handler: nil)
  }
}
