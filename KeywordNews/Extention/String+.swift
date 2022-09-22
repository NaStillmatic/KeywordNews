//
//  String+.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/22.
//

import Foundation

extension String {

  var htmlToString: String {
    guard let data = self.data(using: .utf8) else { return "" }

    do {
      return try NSAttributedString(
        data: data,
        options: [.documentType: NSAttributedString.DocumentType.html,
                   .characterEncoding: String.Encoding.utf8.rawValue],
        documentAttributes: nil).string
    } catch {
      print(error.localizedDescription)
      return ""
    }
  }
}
