//
//  NewsWebViewController.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/21.
//

import UIKit
import SnapKit
import WebKit

final class NewsWebViewController: UIViewController {

  private let webView = WKWebView()
  private lazy var rightBarButtonItem: UIBarButtonItem = {
    return UIBarButtonItem(image: UIImage(systemName: "link"),
                           style: .plain,
                           target: self,
                           action: #selector(didTapRightBarButtonItem))
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    setupNavigationBar()
  }
}

private extension NewsWebViewController {

  func setupNavigationBar() {
    navigationItem.title = "기사 제목"
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }

  func setupWebView() {
    guard let linkUrl = URL(string: "https://daum.net") else {
      navigationController?.popViewController(animated: true)
      return
    }
    view = webView
    let urlRequest = URLRequest(url: linkUrl)
    webView.load(urlRequest)
  }

  @objc func didTapRightBarButtonItem() {
    UIPasteboard.general.string = "뉴스 링크"
  }
}
