//
//  NewsResponseModel.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/22.
//

import Foundation

struct NewsResponseModel: Decodable {

  var items: [News] = []
}

struct News: Decodable {
  
  let title: String
  let link: String
  let description: String
  let pubDate: String
}
