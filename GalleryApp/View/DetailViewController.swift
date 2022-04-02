//
//  DetailViewController.swift
//  GalleryApp
//
//  Created by Yulia Popova on 2/4/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImage()
        configureNavigation()
        configureShareButton()
    }
    
    func configureImage() {
        detailImage.layer.bounds.size.width = view.layer.bounds.width
        detailImage.layer.bounds.size.height = view.layer.bounds.width
        detailImage.image = UIImage(systemName: "0.circle")
    }
    
    func configureNavigation() {
        self.title = "Date"
    }
    
    func configureShareButton() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share))
        shareButton.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func share() {
        let image = detailImage.image!
        presentActivityViewController(image: image)
    }
    
    func presentActivityViewController(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
