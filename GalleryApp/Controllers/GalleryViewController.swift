//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Yulia Popova on 2/4/2022.
//

import UIKit
import SwiftyVK
import Kingfisher

let reusableCellId = "cell_id"

class GalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    private var isPhotosFetched = false

    private lazy var photoService = PhotoService.shared
    private lazy var authService = AuthService.shared

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchPhotos()
        }
    }

    func fetchPhotos() {
        photoService.fetchPhotos { (success: Bool) -> Void in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.isPhotosFetched = true
                    self.collectionView.isHidden = false
                }
            } else {
                let alert = UIAlertController(title: nil, message: AppStrings.networkError.rawValue.localised, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: AppStrings.confirmLogout.rawValue.localised, style: .default, handler: { _ in
                    alert.dismiss(animated: false, completion: nil)
                }))
                self.present(alert, animated: true)
            }
        }
    }

    func configureUI() {
        configureCollectionView()
        configureNavigation()
        
    }

    func configureNavigation() {

        title = "Mobile Up Gallery"

        navigationController!.navigationBar.standardAppearance.shadowColor = .systemBackground
        navigationController!.navigationBar.standardAppearance.backgroundColor = .systemBackground
        navigationController!.navigationBar.scrollEdgeAppearance? = navigationController!.navigationBar.standardAppearance
        
        let exitButton = UIBarButtonItem()
        exitButton.title = AppStrings.exit.rawValue.localised
        exitButton.tintColor = UIColor.black
        exitButton.target = self
        exitButton.action = #selector(logout)
        
        navigationItem.rightBarButtonItem = exitButton
    }

    @objc func logout() {

        let alert = UIAlertController(title: nil, message: AppStrings.logoutConfirmation.rawValue.localised, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: AppStrings.confirmLogout.rawValue.localised, style: .default, handler: { _ in

            self.authService.signOut()
            let signInViewController : SignInViewController = SignInViewController(nibName: "SignInViewController", bundle: nil)
            signInViewController.modalPresentationStyle = .fullScreen
            alert.dismiss(animated: false, completion: nil)
            self.present(signInViewController, animated: true, completion: nil)

        }))

        alert.addAction(UIAlertAction(title: AppStrings.cancelLogout.rawValue.localised, style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)
    }

    func configureCollectionView() {
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: reusableCellId)
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailViewController : DetailViewController = DetailViewController(nibName: "DetailViewController", bundle: nil)

        detailViewController.url = photoService.photos[indexPath.row].optimalSizeImage.url
        detailViewController.date = photoService.photos[indexPath.row].date

        let controller = UINavigationController(rootViewController: detailViewController)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoService.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath) as! GalleryCollectionViewCell
        if isPhotosFetched {
            if let url = URL(string: photoService.photos[indexPath.row].optimalSizeImage.url) {
                cell.imageView.kf.setImage(with: url)
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2 - 1
        return CGSize(width: size, height: size)
    }
}
