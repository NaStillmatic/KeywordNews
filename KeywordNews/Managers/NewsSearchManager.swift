//
//  NewsSearchManager.swift
//  KeywordNews
//
//  Created by HwangByungJo  on 2022/09/22.
//

import Alamofire
import Foundation

protocol NewsSearchManagerProtocol {
  
  func requset(from keyword: String,
               start: Int,
               display: Int,
               completionHandeler: @escaping ([News]) -> Void)
}

struct NewsSearchManager {

  func requset(from keyword: String,
               start: Int,
               display: Int,
               completionHandeler: @escaping ([News]) -> Void) {
    guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json") else { return }
    let parameters = NewsRequestModel(start: start,
                                      display: display,
                                      query: keyword)
    let headers: HTTPHeaders = ["X-Naver-Client-Id": "31Yx_S_nC13mpBeWVt2g",
                                  "X-Naver-Client-Secret": "fEq9F0rhZ_"]

    AF.request(url, method: .get, parameters: parameters, headers: headers)
      .responseDecodable(of: NewsResponseModel.self) { response in
        switch response.result {
          case .success(let result):
            completionHandeler(result.items)
          case .failure(let error):
            print(error)
        }
      }
      .resume()
  }
}
