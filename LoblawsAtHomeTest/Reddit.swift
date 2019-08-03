//
//  Reddit.swift
//  LoblawsAtHomeTest
//
//  Created by Reiss Zurbyk on 2019-08-01.
//  Copyright © 2019 Reiss Zurbyk. All rights reserved.
//

import Foundation

    struct Model : Decodable {
    let data: Children
}

struct Children: Decodable {
    let children: [RedditData]
}

struct RedditData: Decodable {
    let data: SecondaryData
}

struct SecondaryData : Decodable {
    let selftext: String
    let author_fullname: String

    let preview: Images?
}

struct Images: Decodable {
    let images: [Source]
}

struct Source: Decodable {
    let source: ImageURL
}

struct ImageURL: Decodable {
    let url: URL
    let width: Int
    let height: Int
}
