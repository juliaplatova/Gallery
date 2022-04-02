//
//  PhotoResponse.swift
//  GalleryApp
//
//  Created by Yulia Popova on 30/3/2022.
//

import Foundation

struct PhotoResponse: Decodable {
    let items: [Photo]
    let count: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Photo].self, forKey: .items)
        count = try container.decode(Int.self, forKey: .count)
    }

    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
}
