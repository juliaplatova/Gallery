//
//  StringExtension.swift
//  GalleryApp
//
//  Created by Yulia Popova on 3/4/2022.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
