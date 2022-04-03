//
//  SignInViewController.swift
//  GalleryApp
//
//  Created by Yulia Popova on 29/3/2022.
//

import UIKit
import SwiftyVK

class SignInViewController: UIViewController {

    struct UIConstants {
        let cornerRadius = 8.0
    }

    @IBOutlet weak var signInButton: UIButton!

    private lazy var authService = AuthService.shared

    @IBAction func SignInButtonPressed(_ sender: UIButton) {

        authService.signIn { result in
            if case result = AuthResult.success {
                DispatchQueue.main.async {
                    let controller = UINavigationController(rootViewController: GalleryViewController(nibName: "GalleryViewController", bundle: nil))
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: nil, message: AppStrings.networkError.rawValue.localised, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: AppStrings.confirmLogout.rawValue.localised, style: .default, handler: { _ in
                        alert.dismiss(animated: false, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        signInButton.layer.cornerRadius = UIConstants().cornerRadius
        signInButton.titleLabel?.text = AppStrings.signInUsingVK.rawValue.localised
    }

}
