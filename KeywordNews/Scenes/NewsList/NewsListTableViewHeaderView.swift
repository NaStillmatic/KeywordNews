//
//  NewsListTableViewHeaderView.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/21.
//

import UIKit
import TTGTags
import SnapKit

protocol NewsListTableViewHeaderViewDelegate: AnyObject {

  func didSelectTag(_ seletedIndex: Int)
}

final class NewsListTableViewHeaderView: UITableViewHeaderFooterView {

  static let identifier = "NewsListTableViewHeaderView"

  private weak var delegate: NewsListTableViewHeaderViewDelegate?

  private var selectedIndex: UInt = 0

  private var tags: [String] = []

  private let tagCollectionView = TTGTextTagCollectionView()

  func setup(tags: [String], delegate: NewsListTableViewHeaderViewDelegate ) {
    self.tags = tags
    self.delegate = delegate
    setupTagCollectionviewLayout()
    setupTagCollectionView()
  }
}

extension NewsListTableViewHeaderView: TTGTextTagCollectionViewDelegate {

  func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!,
                             didTap tag: TTGTextTag!,
                             at index: UInt) {
    selectedIndex = index
    textTagCollectionView.allTags().forEach { tag in
      let isSelected = selectedIndex == tag.tagId ? true : false
      textTagCollectionView.updateTag(at: tag.tagId, selected: isSelected)
    }
    textTagCollectionView.reload()
    delegate?.didSelectTag(Int(selectedIndex))
  }
}

private extension NewsListTableViewHeaderView {
  func setupTagCollectionviewLayout() {

    addSubview(tagCollectionView)

    tagCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  func setupTagCollectionView() {

    guard tagCollectionView.allTags().isEmpty else { return }
    
    tagCollectionView.delegate = self
    tagCollectionView.numberOfLines = 1
    tagCollectionView.scrollDirection = .horizontal
    tagCollectionView.showsHorizontalScrollIndicator = false
    tagCollectionView.selectionLimit = 2

    let insetValue: CGFloat = 16.0
    tagCollectionView.contentInset = UIEdgeInsets(top: insetValue,
                                                  left: insetValue,
                                                  bottom: insetValue,
                                                  right: insetValue)
    let cornerRadiusValue: CGFloat = 12.0
    let shadowOpacity: CGFloat = 0.0
    let extraSpace: CGSize = CGSize(width: 20.0, height: 12.0)
    let color = UIColor.systemOrange

    let style = TTGTextTagStyle()
    style.backgroundColor = color
    style.cornerRadius = cornerRadiusValue
    style.borderWidth = 0.0
    style.shadowOpacity = shadowOpacity
    style.extraSpace = extraSpace

    let selectedStyle = TTGTextTagStyle()
    selectedStyle.backgroundColor = .white
    selectedStyle.cornerRadius = cornerRadiusValue
    selectedStyle.shadowOpacity = shadowOpacity
    selectedStyle.extraSpace = extraSpace
    selectedStyle.borderColor = color

    let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)

    tags.forEach { tag in
      let tagContents = TTGTextTagStringContent(text: tag,
                                               textFont: font,
                                               textColor: .white)
      let selectedTagContents = TTGTextTagStringContent(text: tag,
                                                       textFont: font,
                                                       textColor: color)
      let tag = TTGTextTag(content: tagContents,
                           style: style,
                           selectedContent: selectedTagContents,
                           selectedStyle: selectedStyle)
      tagCollectionView.addTag(tag)
    }
    tagCollectionView.reload()
  }
}
