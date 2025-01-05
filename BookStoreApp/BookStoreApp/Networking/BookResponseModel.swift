//
//  BookResponseModel.swift
//  BookStoreApp
//
//  Created by Jimin on 12/31/24.
//

import Foundation

struct BookResponseModel: Codable {
    let documents: [Book]
}

struct Book: Codable {
    let authors: [String]
    let contents: String
    let salePrice: Int
    let title: String
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case authors, contents, title, thumbnail
        case salePrice = "sale_price"
    }
}
