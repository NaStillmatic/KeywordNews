//
//  NewsListPresenter.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/20.
//

import Foundation

protocol NewsListProtocol: AnyObject {
  func setupNavigationBar()
}

final class NewsListPresenter {

  private weak var viewController: NewsListProtocol?

  init(viewController: NewsListProtocol) {
    self.viewController = viewController
  }

  func viewDidLoad() {
    viewController?.setupNavigationBar()
  }
}
