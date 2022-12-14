//
//  NewsListTableViewCell.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/20.
//

import UIKit
import SnapKit

final class NewsListTableViewCell: UITableViewCell {

  static let identifier = "NewsListTableViewCell"

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15.0, weight: .semibold)
    return label
  }()

  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14.0, weight: .medium)
    return label
  }()

  private lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12.0, weight: .medium)
    label.textColor = .secondaryLabel
    return label
  }()

  func setup(news: News) {
    setupLayout()
    accessoryType = .disclosureIndicator
    selectionStyle = .none

    titleLabel.text = news.title.htmlToString
    descriptionLabel.text = news.description.htmlToString
    dateLabel.text = news.pubDate
  }
}

private extension NewsListTableViewCell {

  func setupLayout() {
    [
      titleLabel,
      descriptionLabel,
      dateLabel
    ].forEach { contentView.addSubview($0) }

    titleLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(16.0)
    }

    let verticalSpacing: CGFloat = 4.0

    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(titleLabel.snp.leading)
      $0.trailing.equalTo(titleLabel.snp.trailing)
      $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
    }

    dateLabel.snp.makeConstraints {
      $0.leading.equalTo(titleLabel.snp.leading)
      $0.trailing.equalTo(titleLabel.snp.trailing)
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing)
      $0.bottom.equalToSuperview().inset(16.0)
    }
  }
}
