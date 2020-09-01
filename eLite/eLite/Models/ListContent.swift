//
//  ListContent.swift
//  eLite
//
//  Created by Mayur Susare on 29/08/20.
//  Copyright © 2020 Local. All rights reserved.
//

import Foundation

struct ListContent: Codable {
    var id: String?
    var type: String?
    var date: String?
    var data: String?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case date
        case data
    }
}


enum ListContentType: String {
    case image = "image"
    case text = "text"
}
