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
  func moveToNewsWebViewController(news: News)
  func reloadTableView()
}

final class NewsListPresenter: NSObject {

  private weak var viewController: NewsListProtocol?
  private let newsSearchManager: NewsSearchManagerProtocol
  private var newsList: [News] = []
  private var currentPage: Int = 0
  private let display: Int = 20

  private let tags: [String] =  ["IT", "아이폰", "개발", "개발자", "판교", "게임", "앱개발", "스타트업"]

  private lazy var currentKeyword: String = {
    return tags[0]
  }()

  init(viewController: NewsListProtocol,
       newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()) {
    self.viewController = viewController
    self.newsSearchManager = newsSearchManager
  }

  func viewDidLoad() {
    viewController?.setupNavigationBar()
    viewController?.setupLayout()
  }

  func didCalledRefresh() {
    requestNewsList(isNeededToReset: true)
  }
}

extension NewsListPresenter: UITableViewDelegate {

  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    let news = newsList[indexPath.row]
    viewController?.moveToNewsWebViewController(news: news)
  }

  func tableView(_ tableView: UITableView,
                 willDisplay cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    let currentRow = indexPath.row

    guard currentRow % 20 == display - 3 &&
          (currentRow / display) == (currentPage - 1) else {
      return
    }
    requestNewsList(isNeededToReset: false)
  }
}

extension NewsListPresenter: UITableViewDataSource {

  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return newsList.count
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier,
                                                   for: indexPath) as? NewsListTableViewCell else { return UITableViewCell() }
    if indexPath.row < newsList.count {
      let news = newsList[indexPath.row]
      cell.setup(news: news)
    }
    return cell
  }

  func tableView(_ tableView: UITableView,
                 viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListTableViewHeaderView.identifier) as? NewsListTableViewHeaderView else { return nil }
    header.setup(tags: tags, delegate: self)
    return header
  }
}

private extension NewsListPresenter {

  func requestNewsList(isNeededToReset: Bool) {
    if isNeededToReset {
      currentPage = 0
      newsList.removeAll()
    }
    newsSearchManager.requset(from: currentKeyword,
                              start: (currentPage * display) + 1,
                              display: display) { [weak self] newValue in
      self?.currentPage += 1
      self?.newsList += newValue
      self?.viewController?.reloadTableView()
      self?.viewController?.endRefreshing()
    }
  }
}

extension NewsListPresenter: NewsListTableViewHeaderViewDelegate {

  func didSelectTag(_ seletedIndex: Int) {
    currentKeyword = tags[seletedIndex]
    requestNewsList(isNeededToReset: true)
  }
}
