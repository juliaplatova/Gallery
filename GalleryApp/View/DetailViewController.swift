//
//  DetailViewController.swift
//  GalleryApp
//
//  Created by Yulia Popova on 2/4/2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    
    var url : String?
    var date : Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImage()
        configureNavigation()
        configureShareButton()
        configureBackButton()
    }
    
    func configureImage() {
        detailImage.layer.bounds.size.width = view.layer.bounds.width
        detailImage.layer.bounds.size.height = view.layer.bounds.width
        let photoURL = URL(string: url!)
        detailImage.kf.setImage(with: photoURL)
    }
    
    func configureNavigation() {
        let date = Date(timeIntervalSince1970: date!)
        let formater = DateFormatter()
        formater.dateFormat = "dd.mm.yyyy"
        self.title = formater.string(from: date)
    }
    
    func configureBackButton() {

        var backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(back))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
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
    
    @objc func back() {
        let galleryViewController : GalleryViewController = GalleryViewController(nibName: "GalleryViewController", bundle: nil)
        let controller = UINavigationController(rootViewController: galleryViewController)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false, completion: nil)
    }
    
    func presentActivityViewController(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: false, completion: nil)
    }
}
