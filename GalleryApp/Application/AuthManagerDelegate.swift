//
//  AuthManagerDelegate.swift
//  GalleryApp
//
//  Created by Yulia Popova on 30/3/2022.
//

import SwiftyVK

class AuthManagerDelegate : SwiftyVKDelegate {
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return []
    }

    init() {
        VK.setUp(appId: "8120276", delegate: self)
        VK.sessions.default.config.attemptTimeout = 10
    }

    func vkNeedToPresent(viewController: VKViewController) {

        if var currentViewController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController {
            while let presentedVC = currentViewController.presentedViewController {
                currentViewController = presentedVC
            }
            currentViewController.present(viewController, animated: true, completion: nil)
        }
    }

    func vkTokenCreated(for sessionId: String, info: [String: String]) {
        print(#function, sessionId, info)
    }

    func vkTokenUpdated(for sessionId: String, info: [String: String]) {
        print(#function, sessionId, info)
    }

    func vkTokenRemoved(for sessionId: String) {
        print(#function, sessionId)
    }

}

