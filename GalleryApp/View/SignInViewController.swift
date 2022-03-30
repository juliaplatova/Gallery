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
    
    var viewModel: SignInViewModel = SignInViewModel()
    
    @IBAction func SignInButtonPressed(_ sender: UIButton) {

        viewModel.signIn { result in
            if case result = AuthResult.success {
                DispatchQueue.main.async {
                    let controller = UINavigationController(rootViewController: GalleryViewController(nibName: "GalleryViewController", bundle: nil))
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    // MARK: - Alert should be here
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
    }

}
