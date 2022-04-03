//
//  GalleryCollectionViewCell.swift
//  GalleryApp
//
//  Created by Yulia Popova on 2/4/2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "placeholder.png")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureImage() {

        contentView.addSubview(imageView)

        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

    }
}
