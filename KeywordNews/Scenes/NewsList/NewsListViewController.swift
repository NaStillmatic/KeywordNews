//
//  NewsListViewController.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/20.
//

import UIKit

final class NewsListViewController: UIViewController {

  private lazy var presenter = NewsListPresenter(viewController: self)
  override func viewDidLoad() {
    super.viewDidLoad()


    presenter.viewDidLoad()
  }
}

extension NewsListViewController: NewsListProtocol {

  func setupNavigationBar() {
    navigationItem.title = "News"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}



