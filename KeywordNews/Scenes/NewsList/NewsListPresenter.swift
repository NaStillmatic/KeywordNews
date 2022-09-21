//
//  NewsListPresenter.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/20.
//

import UIKit

protocol NewsListProtocol: AnyObject {

  func setupNavigationBar()
  func setupLayout()
  func endRefreshing()
}

final class NewsListPresenter: NSObject {

  private weak var viewController: NewsListProtocol?

  init(viewController: NewsListProtocol) {
    self.viewController = viewController
  }

  func viewDidLoad() {
    viewController?.setupNavigationBar()
    viewController?.setupLayout()
  }

  func didCalledRefresh() {
    viewController?.endRefreshing()
  }
}

extension NewsListPresenter: UITableViewDelegate {}

extension NewsListPresenter: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier,
                                                   for: indexPath) as? NewsListTableViewCell else { return UITableViewCell() }
    cell.setup()
    return cell
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListTableViewHeaderView.identifier) as? NewsListTableViewHeaderView else { return nil }
    header.setup()
    return header
  }
}
