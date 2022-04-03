//
//  Info.swift
//  GalleryApp
//
//  Created by Yulia Popova on 30/3/2022.
//

import Foundation

struct Info: Decodable {
    
    let url: String
    let type: String
    let height: Int
    let width: Int

    enum InfoCodingKeys: String, CodingKey {
        case height
        case width
        case url
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: InfoCodingKeys.self)
        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
        url = try container.decode(String.self, forKey: .url)
        type = try container.decode(String.self, forKey: .type)
    }
}
