//
//  Photo.swift
//  GalleryApp
//
//  Created by Yulia Popova on 30/3/2022.
//

import Foundation

struct Photo: Decodable {
    
    let date: Double
    let info: [Info]

    var optimalSizeImage: Info {
        var width = 0, j = 0
        for i in 0...(info.count - 1) {
            if info[i].width > width && info[i].width < 800 {
                width = info[i].width
                j = i
            }
        }
        return info[j]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoCodingKeys.self)

        date = try container.decode(Double.self, forKey: .date)
        info = try container.decode([Info].self, forKey: .info)
    }

    enum PhotoCodingKeys: String, CodingKey {
        case date
        case info = "sizes"
    }
}
