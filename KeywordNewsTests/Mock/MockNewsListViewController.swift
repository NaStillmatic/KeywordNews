//
//  MockNewsListViewController.swift
//  KeywordNewsTests
//
//  Created by HwangByungJo  on 2022/09/23.
//

import XCTest

@testable import KeywordNews

final class MockNewsListViewController: NewsListProtocol {

  var isCalledSetupNavigationBar  = false
  var isCalledSetupLayout  = false
  var isCalledEndRefreshing  = false
  var isCalledMoveToNewsWebViewController  = false
  var isCalledReloadTableView  = false

  func setupNavigationBar() {

    isCalledSetupNavigationBar = true
  }

  func setupLayout() {
    isCalledSetupLayout = true
  }

  func endRefreshing() {
    isCalledEndRefreshing = true
  }

  func moveToNewsWebViewController(news: KeywordNews.News) {
    isCalledMoveToNewsWebViewController = true
  }

  func reloadTableView() {
    isCalledReloadTableView = true
  }
}
