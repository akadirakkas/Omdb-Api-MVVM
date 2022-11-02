//
//  UIApplication+Extensions.swift
//  kalimbaNotes
//
//  Created by Erdi Tunçalp on 2.07.2022.
//

import UIKit

extension UIApplication {

    var currentKeyWindow: UIWindow? {
        return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
    }
}
