//
//  SignInViewController.swift
//  GalleryApp
//
//  Created by Yulia Popova on 29/3/2022.
//

import UIKit

class SignInViewController: UIViewController {

    struct UIConstants {
        let cornerRadius = 8.0
    }
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func SignInButtonPressed(_ sender: UIButton) {
        // MARK: - Sign in action
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        signInButton.layer.cornerRadius = UIConstants().cornerRadius
    }

}
