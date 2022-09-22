//
//  NewsListViewController.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/20.
//

import UIKit
import SnapKit

final class NewsListViewController: UIViewController {

  private lazy var presenter = NewsListPresenter(viewController: self)
  private lazy var refreshControl: UIRefreshControl = {

    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self,
                             action: #selector(didCalledRefresh),
                             for: .valueChanged)
    return refreshControl
  }()

  private lazy var tableview: UITableView = {
    let tableView = UITableView()
    tableView.delegate = presenter
    tableView.dataSource = presenter
    tableView.refreshControl = refreshControl
    tableView.register(NewsListTableViewCell.self,
                       forCellReuseIdentifier: NewsListTableViewCell.identifier)
    tableView.register(NewsListTableViewHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsListTableViewHeaderView.identifier)
    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()

    NewsSearchManager().requset(from: "아이폰", start: 1, display: 20) { news in
      print(news)
    }
  }
}

extension NewsListViewController: NewsListProtocol {

  func setupNavigationBar() {
    navigationItem.title = "News"
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  func setupLayout() {
    view.addSubview(tableview)

    tableview.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func endRefreshing() {
    refreshControl.endRefreshing()
  }

  func moveToNewsWebViewController() {
    let newsWebViewController = NewsWebViewController()
    navigationController?.pushViewController(newsWebViewController, animated: true)
  }
}

private extension NewsListViewController {
  @objc func didCalledRefresh() {
    presenter.didCalledRefresh()
  }
}



