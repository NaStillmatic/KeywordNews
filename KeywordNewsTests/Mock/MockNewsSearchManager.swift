//
//  MockNewsSearchManager.swift
//  KeywordNewsTests
//
//  Created by HwangByungJo  on 2022/09/23.
//

import XCTest

@testable import KeywordNews

final class MockNewsSearchManager: NewsSearchManagerProtocol {

  var error: Error?
  var isCalledRequest = false

  func requset(from keyword: String,
               start: Int,
               display: Int,
               completionHandeler: @escaping ([News]) -> Void) {
    isCalledRequest = true
    if error == nil {
      completionHandeler([])
    }
  }
}
