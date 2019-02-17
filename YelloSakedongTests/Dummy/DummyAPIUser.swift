//
//  DummyAPIUser.swift
//  YelloSakedongTests
//
//  Created by Presto on 17/02/2019.
//  Copyright © 2019 nexters. All rights reserved.
//

import Foundation

struct DummyAPIUser {
  
  static let responseCreated = """
  {
    "message": "user created",
    "userId": "5c67b7b8ff8b526d8ab28aaf"
  }
  """
  
  static let responseConflict = """
  {
    "message": "device key exists"
  }
  """
  
  static let responseInternalServerError = """
  {
    "error": {
      "errors": {
        "yellowSakedongKey": {
          "message": "Path `yellowSakedongKey` is required.",
          "name": "ValidatorError",
          "properties": {
            "message": "Path `yellowSakedongKey` is required.",
            "type": "required",
            "path": "yellowSakedongKey"
          },
          "kind": "required",
          "path": "yellowSakedongKey"
        }
      },
      "_message": "User validation failed",
      "message": "User validation failed: yellowSakedongKey: Path `yellowSakedongKey` is required.",
      "name": "ValidationError"
    }
  }
  """
}
