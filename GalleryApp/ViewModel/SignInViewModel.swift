//
//  SignInViewModel.swift
//  GalleryApp
//
//  Created by Yulia Popova on 30/3/2022.
//

import Foundation

class SignInViewModel {
    
    var model : SignInModel = SignInModel()
    
    public func signIn(completion: @escaping (AuthResult) -> ()) {
        
        model.signIn { result in

            completion(result)

        }
    }
    
}
