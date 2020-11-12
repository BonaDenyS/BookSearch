//
//  Book.swift
//  BookSearch
//
//  Created by Bona Deny S on 11/8/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import Foundation

struct Raw: Decodable {
    let totalItems: Int
    let items: [Item]
}

struct Item: Decodable, Hashable {
    let volumeInfo: Book
}

struct Book: Decodable, Hashable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let imageLinks: ImageLink?
    let averageRating: Float?
    let ratingsCount: Int?
}

struct ImageLink: Decodable, Hashable {
    let smallTumbhnail: String?
    let thumbnail: String
}
