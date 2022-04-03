//
//  ScaleExtension.swift
//  GalleryApp
//
//  Created by Yulia Popova on 3/4/2022.
//

import UIKit

extension UIImageView {

    struct StoredScale {
        static var value: Double = 1.0
    }
    var currentScale : Double {
        get {
            return StoredScale.value
        }
        set(newValue) {
            StoredScale.value = newValue
        }
    }
    
    func enableScale() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startScale(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }

    @objc private func startScale(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .changed {
            if (currentScale * sender.scale > 1 && currentScale * sender.scale < 2) {
                currentScale = currentScale * sender.scale
                print(sender.scale)
                let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
                guard let scale = scaleResult else { return }
                sender.view?.transform = scale
            }
            sender.scale = 1
        } else if sender.state == .ended {
            let scaleResult = sender.view?.transform.scaledBy(x: (1 / currentScale), y: (1 / currentScale))
            sender.view?.transform = scaleResult!
            currentScale = 1.0
        }
    }
}
