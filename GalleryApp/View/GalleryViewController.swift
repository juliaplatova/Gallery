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
    
    private lazy var photoService = PhotoService(for: self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = [Photo]()
    
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
            }
        }
    }
    
    func configureUI() {
        configureCollectionView()
        configureNavigation()
        
    }
    
    func configureNavigation() {
        
        title = "Mobile Up Gallery"
        
        var exitButton = UIBarButtonItem()
        exitButton.title = "Exit"
        exitButton.tintColor = UIColor.black
        exitButton.target = self
        exitButton.action = #selector(logout)
        
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc func logout() {
        NSLog("Exit button pressed")
    }
    
    func configureCollectionView() {
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: reusableCellId)
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath) as! GalleryCollectionViewCell
        if isPhotosFetched {
            if let url = URL(string: photos[indexPath.row].optimalSizeImage.url) {
                cell.imageView.kf.setImage(with: url)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2
        return CGSize(width: size, height: size)
    }
}
