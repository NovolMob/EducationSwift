//
//  ArticleRequest.swift
//  FirstApplication
//
//  Created by Antares on 24.11.2021.
//

import Foundation
struct ArticleResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleItem]
}
